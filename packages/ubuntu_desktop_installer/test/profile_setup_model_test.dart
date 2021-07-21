import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:ubuntu_desktop_installer/pages/profile_setup/profile_setup_model.dart';
import 'package:ubuntu_desktop_installer/utils.dart';

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
    final client = MockSubiquityClient();

    final model = ProfileSetupModel(client);
    model.username = 'ubuntu';
    model.password = 'password';

    final identity = IdentityData(
      username: model.username,
      cryptedPassword: encryptPassword('password', salt: 'test'),
    );

    await model.saveProfileSetup(salt: 'test');
    verify(client.setIdentity(identity)).called(1);
  });

  test('password strength', () {
    // see password_test.dart for more detailed password strength tests
    final model = ProfileSetupModel(MockSubiquityClient());

    void testPasswordStrength(String password, Matcher matcher) {
      model.password = password;
      expect(model.passwordStrength, matcher);
    }

    testPasswordStrength('password', equals(PasswordStrength.weak));
    testPasswordStrength('P4ssword', equals(PasswordStrength.moderate));
    testPasswordStrength('P@ssw0rd123', equals(PasswordStrength.strong));
  });

  test('notify changes', () {
    final model = ProfileSetupModel(MockSubiquityClient());

    var wasNotified = false;
    model.addListener(() => wasNotified = true);

    wasNotified = false;
    expect(model.username, isEmpty);
    model.username = 'ubuntu';
    expect(wasNotified, isTrue);

    wasNotified = false;
    expect(model.password, isEmpty);
    model.password = 'password';
    expect(wasNotified, isTrue);

    wasNotified = false;
    expect(model.showAdvancedOptions, isFalse);
    model.showAdvancedOptions = true;
    expect(wasNotified, isTrue);
  });
}
