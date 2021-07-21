import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_desktop_installer/pages/profile_setup/profile_setup_model.dart';
import 'package:ubuntu_desktop_installer/pages/profile_setup/profile_setup_page.dart';
import 'package:wizard_router/wizard_router.dart';

import 'profile_setup_page_test.mocks.dart';

extension LangTester<T> on WidgetTester {
  AppLocalizations get lang {
    final page = element(find.byType(ProfileSetupPage));
    return AppLocalizations.of(page)!;
  }
}

@GenerateMocks([ProfileSetupModel])
void main() {
  ProfileSetupModel buildModel({
    bool? isValid,
    String? username,
    String? password,
    PasswordStrength? passwordStrength,
    bool? showAdvancedOptions,
  }) {
    final model = MockProfileSetupModel();
    when(model.isValid).thenReturn(isValid ?? false);
    when(model.username).thenReturn(username ?? '');
    when(model.password).thenReturn(password ?? '');
    when(model.passwordStrength)
        .thenReturn(passwordStrength ?? PasswordStrength.weak);
    when(model.showAdvancedOptions).thenReturn(showAdvancedOptions ?? false);
    return model;
  }

  Widget buildPage(ProfileSetupModel model) {
    return ChangeNotifierProvider<ProfileSetupModel>.value(
      value: model,
      child: ProfileSetupPage(),
    );
  }

  Widget buildApp(ProfileSetupModel model) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Wizard(
        routes: {'/': (_) => buildPage(model)},
      ),
    );
  }

  testWidgets('username input', (tester) async {
    final model = buildModel(username: 'username');
    await tester.pumpWidget(buildApp(model));

    final textField = find.widgetWithText(TextField, 'username');
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'ubuntu');
    verify(model.username = 'ubuntu').called(1);
  });

  testWidgets('password input', (tester) async {
    final model = buildModel(password: 'password');
    await tester.pumpWidget(buildApp(model));

    final textField = find.widgetWithText(TextField, 'password');
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'ubuntu');
    verify(model.password = 'ubuntu').called(1);
  });

  testWidgets('empty password', (tester) async {
    final model = buildModel(password: '');
    await tester.pumpWidget(buildApp(model));

    expect(find.text(tester.lang.weakPassword), findsNothing);
    expect(find.text(tester.lang.moderatePassword), findsNothing);
    expect(find.text(tester.lang.strongPassword), findsNothing);
  });

  testWidgets('weak password', (tester) async {
    final model = buildModel(
      password: 'not empty',
      passwordStrength: PasswordStrength.weak,
    );
    await tester.pumpWidget(buildApp(model));

    expect(find.text(tester.lang.weakPassword), findsOneWidget);
  });

  testWidgets('moderate password', (tester) async {
    final model = buildModel(
      password: 'not empty',
      passwordStrength: PasswordStrength.moderate,
    );
    await tester.pumpWidget(buildApp(model));

    expect(find.text(tester.lang.moderatePassword), findsOneWidget);
  });

  testWidgets('strong password', (tester) async {
    final model = buildModel(
      password: 'not empty',
      passwordStrength: PasswordStrength.strong,
    );
    await tester.pumpWidget(buildApp(model));

    expect(find.text(tester.lang.strongPassword), findsOneWidget);
  });
}
