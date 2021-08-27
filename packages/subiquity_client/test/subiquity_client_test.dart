import 'dart:io';

import 'package:subiquity_client/src/types.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:subiquity_client/subiquity_server.dart';
import 'package:test/test.dart';

void main() {
  late SubiquityServer _testServer;
  late SubiquityClient _client;
  var _socketPath;

  group('subiquity', () {
    setUpAll(() async {
      _testServer = SubiquityServer();
      _client = SubiquityClient();
      _socketPath = await _testServer.start(
          ServerMode.DRY_RUN, ['--machine-config', 'examples/simple.json']);
      _client.open(_socketPath);
    });

    tearDownAll(() async {
      await _client.close();
      await _testServer.stop();
    });

    test('locale', () async {
      await _client.setLocale('en_US.UTF-8');
      expect(await _client.locale(), 'en_US.UTF-8');
    });

    test('keyboard', () async {
      var ks = KeyboardSetting(
        layout: 'us',
        variant: '',
        toggle: null,
      );

      await _client.setKeyboard(ks);

      var kb = await _client.keyboard();
      expect(kb.setting?.layout, 'us');
      expect(kb.setting?.variant, '');
      expect(kb.setting?.toggle, null);
      expect(kb.layouts, isNotEmpty);
    });

    test('has rst', () async {
      var rst = await _client.hasRst();
      expect(rst, isFalse);
    });

    test('has bitlocker', () async {
      var bitLocker = await _client.hasBitLocker();
      expect(bitLocker, isFalse);
    });

    test('guided storage', () async {
      var gs = await _client.getGuidedStorage(0, true);
      expect(gs.disks, isNotEmpty);
      expect(gs.disks?[0].size, isNot(0));

      var gc = GuidedChoice(
        diskId: 'invalid',
        useLvm: false,
        password: '',
      );

      // TODO: Re-enable once we figure out why _client.send() sometimes hangs in setGuidedStorage()
      // try {
      //   await _client.setGuidedStorage(gc); // should throw
      //   // ignore: avoid_catches_without_on_clauses
      // } catch (e) {
      //   expect(
      //       e,
      //       startsWith(
      //           'setGuidedStorage({"disk_id":"invalid","use_lvm":false,"password":""}) returned error 500'));
      // }

      gc = GuidedChoice(
        diskId: gs.disks?[0].id,
        useLvm: false,
        password: '',
      );

      var sr = await _client.setGuidedStorage(gc);
      expect(sr.status, ProbeStatus.DONE);

      await _client.setStorage(sr.config!);
    });

    test('proxy', () async {
      // TODO: Re-enable once we figure out why _client.setProxy() sometimes hangs
      // await _client.setProxy('test');
      // expect(await _client.proxy(), 'test');
      // await _client.setProxy('');
      expect(await _client.proxy(), '');
    });

    test('mirror', () async {
      await _client.setMirror('test');
      expect(await _client.mirror(), endsWith('test'));
      await _client.setMirror('archive.ubuntu.com/ubuntu');
      expect(await _client.mirror(), endsWith('archive.ubuntu.com/ubuntu'));
    });

    test('identity', () async {
      var newId = IdentityData(
        realname: 'ubuntu',
        username: 'ubuntu',
        cryptedPassword:
            r'$6$exDY1mhS4KUYCE/2$zmn9ToZwTKLhCw.b4/b.ZRTIZM30JZ4QrOQ2aOXJ8yk96xpcCof0kxKwuX1kqLG/ygbJ1f8wxED22bTL4F46P0',
        hostname: 'ubuntu-desktop',
      );

      await _client.setIdentity(newId);

      var id = await _client.identity();
      expect(id.realname, 'ubuntu');
      expect(id.username, 'ubuntu');
      expect(id.cryptedPassword, '');
      expect(id.hostname, 'ubuntu-desktop');

      newId = IdentityData(
        realname: '',
        username: '',
        cryptedPassword: '',
        hostname: '',
      );

      await _client.setIdentity(newId);

      id = await _client.identity();
      expect(id.realname, '');
      expect(id.username, '');
      expect(id.cryptedPassword, '');
      expect(id.hostname, '');
    });

    test('timezone', () async {
      final systemTimezone =
          Process.runSync('timedatectl', ['show', '-p', 'Timezone', '--value'])
              .stdout
              .toString()
              .trim();
      var tzdata = await _client.timezone();
      expect(tzdata.timezone, systemTimezone);

      try {
        await _client.setTimezone('Pacific/Guam');
        tzdata = await _client.timezone();
        expect(tzdata.timezone, 'Pacific/Guam');
        expect(tzdata.fromGeoIP, isFalse);
      } finally {
        // Restore initial timezone to leave the test system in a clean state
        await _client.setTimezone(systemTimezone);
      }
    },
        skip:
            'fails on headless test systems (CI) because subiquity calls `timedatectl set-timezone`, which requires sudo');

    test('ssh', () async {
      var newSsh = SSHData(
        installServer: true,
        allowPw: false,
        authorizedKeys: [],
      );

      await _client.setSsh(newSsh);

      var ssh = await _client.ssh();
      expect(ssh.installServer, true);
      expect(ssh.allowPw, false);
      expect(ssh.authorizedKeys, []);

      newSsh = SSHData(
        installServer: false,
        allowPw: true,
        authorizedKeys: [],
      );

      await _client.setSsh(newSsh);

      ssh = await _client.ssh();
      expect(ssh.installServer, false);
      expect(ssh.allowPw, true);
      expect(ssh.authorizedKeys, []);
    });

    test('status', () async {
      var status = await _client.status();
      expect(status.state, ApplicationState.WAITING);
      expect(status.confirmingTty, '');
      expect(status.cloudInitOk, true);
      expect(status.interactive, true);
      expect(status.echoSyslogId, startsWith('subiquity_echo.'));
      expect(status.logSyslogId, startsWith('subiquity_log.'));
      expect(status.eventSyslogId, startsWith('subiquity_event.'));

      // Should not block as the status is currently WAITING
      status = await _client.status(current: ApplicationState.RUNNING);
    });

    test('markConfigured', () async {
      await _client.markConfigured(['keyboard']);
    });

    test('confirm', () async {
      await _client.confirm('1');
    });
  });

  group('wsl', () {
    setUpAll(() async {
      _testServer = SubiquityServer.wsl();
      _client = SubiquityClient();
      _socketPath = await _testServer.start(ServerMode.DRY_RUN, []);
      _client.open(_socketPath);
    });

    tearDownAll(() async {
      await _client.close();
      await _testServer.stop();
    });

    test('wslconf1', () async {
      var newConf = WSLConfiguration1Data(
        customPath: '/mnt/',
        customMountOpt: '-f',
        genHost: false,
        genResolvconf: false,
      );

      await _client.setWslConfiguration1(newConf);

      var conf = await _client.wslConfiguration1();
      expect(conf.customPath, '/mnt/');
      expect(conf.customMountOpt, '-f');
      expect(conf.genHost, false);
      expect(conf.genResolvconf, false);

      newConf = WSLConfiguration1Data(
        customPath: '',
        customMountOpt: '',
        genHost: true,
        genResolvconf: true,
      );

      await _client.setWslConfiguration1(newConf);

      conf = await _client.wslConfiguration1();
      expect(conf.customPath, '');
      expect(conf.customMountOpt, '');
      expect(conf.genHost, true);
      expect(conf.genResolvconf, true);
    });

    test('wslconf2', () async {
      var newConf = WSLConfiguration2Data(
        guiTheme: 'default',
        guiFollowwintheme: true,
        legacyGui: false,
        legacyAudio: false,
        advIpDetect: false,
        wslMotdNews: true,
        automount: true,
        mountfstab: true,
        customPath: '/mnt/',
        customMountOpt: '-f',
        genHost: false,
        genResolvconf: false,
        interopEnabled: true,
        interopAppendwindowspath: true,
      );

      await _client.setWslConfiguration2(newConf);

      var conf = await _client.wslConfiguration2();
      expect(conf.guiTheme, 'default');
      expect(conf.guiFollowwintheme, true);
      expect(conf.legacyGui, false);
      expect(conf.legacyAudio, false);
      expect(conf.advIpDetect, false);
      expect(conf.wslMotdNews, true);
      expect(conf.automount, true);
      expect(conf.mountfstab, true);
      expect(conf.customPath, '/mnt/');
      expect(conf.customMountOpt, '-f');
      expect(conf.genHost, false);
      expect(conf.genResolvconf, false);
      expect(conf.interopEnabled, true);
      expect(conf.interopAppendwindowspath, true);

      newConf = WSLConfiguration2Data(
        guiTheme: '',
        guiFollowwintheme: false,
        legacyGui: true,
        legacyAudio: true,
        advIpDetect: true,
        wslMotdNews: false,
        automount: false,
        mountfstab: false,
        customPath: '',
        customMountOpt: '',
        genHost: true,
        genResolvconf: true,
        interopEnabled: false,
        interopAppendwindowspath: false,
      );

      await _client.setWslConfiguration2(newConf);

      conf = await _client.wslConfiguration2();
      expect(conf.guiTheme, '');
      expect(conf.guiFollowwintheme, false);
      expect(conf.legacyGui, true);
      expect(conf.legacyAudio, true);
      expect(conf.advIpDetect, true);
      expect(conf.wslMotdNews, false);
      expect(conf.automount, false);
      expect(conf.mountfstab, false);
      expect(conf.customPath, '');
      expect(conf.customMountOpt, '');
      expect(conf.genHost, true);
      expect(conf.genResolvconf, true);
      expect(conf.interopEnabled, false);
      expect(conf.interopAppendwindowspath, false);
    });
  });
}
