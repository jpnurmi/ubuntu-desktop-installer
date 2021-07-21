import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:ubuntu_desktop_installer/pages/profile_setup/profile_setup_model.dart';

import 'profile_setup_model_test.mocks.dart';

@GenerateMocks([SubiquityClient])
void main() {
  test('load profile setup', () async {
    const identity = IdentityData(
      username: 'ubuntu',
      cryptedPassword: 'anything',
    );

    final client = MockSubiquityClient();
    when(client.identity()).thenAnswer((_) async => identity);

    final model = ProfileSetupModel(client);
    await model.loadProfileSetup();
    verify(client.identity()).called(1);

    expect(model.username, equals(identity.username));
    expect(model.password, isEmpty);
  });

  test('load null profile', () async {
    final client = MockSubiquityClient();
    when(client.identity()).thenAnswer((_) async => IdentityData());

    final model = ProfileSetupModel(client);
    await model.loadProfileSetup();
    verify(client.identity()).called(1);

    expect(model.username, isEmpty);
    expect(model.password, isEmpty);
  });

  test('save profile', () async {
    final identity = IdentityData(
      realname: 'Ubuntu',
      username: 'ubuntu',
      cryptedPassword: ProfileSetupModel.encryptPassword('passwd'),
      hostname: 'impish',
    );

    final client = MockSubiquityClient();

    final model = ProfileSetupModel(client);
    model.username = identity.username!;
    model.password = 'passwd';

    await model.saveProfileSetup();

    verify(client.setIdentity(identity)).called(1);
  });

  test('encrypt password', () {
    const salt = 'abcdefghijklmnopqrstuvwxyz'
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        '0123456789./';

    final password = 'passwd';
    final encrypted =
        ProfileSetupModel.encryptPassword(password, salt: 'ubuntu');
    final decrypted = ProfileSetupModel.decryptPassword(encrypted);
    expect(decrypted, equals(password));
    expect(encrypted, isNot(equals(password)));
  });

  // test('notify changes', () {
  //   final model = WhoAreYouModel(MockSubiquityClient());

  //   var wasNotified = false;
  //   model.addListener(() => wasNotified = true);

  //   wasNotified = false;
  //   expect(model.loginStrategy, LoginStrategy.requirePassword);
  //   model.loginStrategy = LoginStrategy.autoLogin;
  //   expect(wasNotified, isTrue);

  //   wasNotified = false;
  //   expect(model.realName, isEmpty);
  //   model.realName = 'Ubuntu';
  //   expect(wasNotified, isTrue);

  //   wasNotified = false;
  //   expect(model.username, isEmpty);
  //   model.username = 'ubuntu';
  //   expect(wasNotified, isTrue);

  //   wasNotified = false;
  //   expect(model.password, isEmpty);
  //   model.password = 'passwd';
  //   expect(wasNotified, isTrue);

  //   wasNotified = false;
  //   expect(model.hostName, isEmpty);
  //   model.hostName = 'impish';
  //   expect(wasNotified, isTrue);
  // });

  // test('password strength', () {
  //   final model = WhoAreYouModel(MockSubiquityClient());

  //   void testPasswordStrength(String password, Matcher matcher) {
  //     model.password = password;
  //     expect(model.passwordStrength, matcher);
  //   }

  //   testPasswordStrength('', isNull);
  //   testPasswordStrength('p', isNull);

  //   // 2
  //   testPasswordStrength('pw', equals(PasswordStrength.weakPassword));
  //   testPasswordStrength('p4', equals(PasswordStrength.weakPassword));
  //   testPasswordStrength('p@', equals(PasswordStrength.weakPassword));

  //   // 6
  //   testPasswordStrength('passwd', equals(PasswordStrength.weakPassword));
  //   testPasswordStrength('p4sswd', equals(PasswordStrength.averagePassword));
  //   // FIXME: 'p@sswd' should be considered average if 'p4sswd' is
  //   testPasswordStrength('p@sswd', equals(PasswordStrength.weakPassword));

  //   // 8
  //   testPasswordStrength('password', equals(PasswordStrength.weakPassword));
  //   testPasswordStrength('Password', equals(PasswordStrength.weakPassword));
  //   testPasswordStrength('p4ssword', equals(PasswordStrength.averagePassword));
  //   testPasswordStrength('P4ssword', equals(PasswordStrength.averagePassword));
  //   testPasswordStrength('p@ssw0rd', equals(PasswordStrength.averagePassword));
  //   testPasswordStrength('P@ssw0rd', equals(PasswordStrength.averagePassword));

  //   // 9
  //   testPasswordStrength('passsword', equals(PasswordStrength.weakPassword));
  //   testPasswordStrength('p4sssword', equals(PasswordStrength.averagePassword));
  //   testPasswordStrength('P4sssword', equals(PasswordStrength.averagePassword));
  //   testPasswordStrength('p@sssword', equals(PasswordStrength.strongPassword));
  //   testPasswordStrength('P@sssword', equals(PasswordStrength.strongPassword));
  //   testPasswordStrength('p@sssw0rd', equals(PasswordStrength.strongPassword));
  //   testPasswordStrength('P@sssw0rd', equals(PasswordStrength.strongPassword));
  // });
}
