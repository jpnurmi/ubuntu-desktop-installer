part of 'profile_setup_page.dart';

class _UsernameFormField extends StatelessWidget {
  const _UsernameFormField({
    Key? key,
    required this.lang,
    required this.model,
    required this.fieldWidth,
  }) : super(key: key);

  final AppLocalizations lang;
  final ProfileSetupModel model;
  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    return ValidatedFormField(
      spacing: _kIconSpacing,
      fieldWidth: fieldWidth,
      initialValue: model.username,
      onChanged: (value) => model.username = value,
      labelText: lang.profileSetupUsernameHint,
      helperText: lang.profileSetupUsernameHelper,
      successWidget: _SuccessIcon(),
      validator: MultiValidator([
        RequiredValidator(errorText: lang.usernameRequired),
        PatternValidator(
          kValidUsernamePattern,
          errorText: lang.usernameInvalid,
        )
      ]),
    );
  }
}

class _PasswordFormField extends StatelessWidget {
  const _PasswordFormField({
    Key? key,
    required this.lang,
    required this.model,
    required this.fieldWidth,
  }) : super(key: key);

  final AppLocalizations lang;
  final ProfileSetupModel model;
  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    return ValidatedFormField(
      spacing: _kIconSpacing,
      fieldWidth: fieldWidth,
      initialValue: model.password,
      onChanged: (value) => model.password = value,
      obscureText: true,
      labelText: lang.profileSetupPasswordHint,
      successWidget: _PasswordStrengthLabel(
        password: model.password,
        strength: model.passwordStrength,
      ),
      validator: RequiredValidator(
        errorText: lang.passwordRequired,
      ),
    );
  }
}

class _ConfirmPasswordFormField extends StatelessWidget {
  const _ConfirmPasswordFormField({
    Key? key,
    required this.lang,
    required this.model,
    required this.fieldWidth,
  }) : super(key: key);

  final AppLocalizations lang;
  final ProfileSetupModel model;
  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    return ValidatedFormField(
      spacing: _kIconSpacing,
      fieldWidth: fieldWidth,
      obscureText: true,
      labelText: lang.profileSetupConfirmPasswordHint,
      successWidget: _SuccessIcon(),
      validator: _ConfirmPasswordValidator(
        model.password,
        errorText: lang.passwordMismatch,
      ),
    );
  }
}

class _ConfirmPasswordValidator extends FieldValidator<String?> {
  final String _password;

  _ConfirmPasswordValidator(this._password, {required String errorText})
      : super(errorText);

  @override
  bool isValid(String? value) {
    return value?.isNotEmpty == true && value == _password;
  }
}

class _PasswordStrengthLabel extends StatelessWidget {
  const _PasswordStrengthLabel({
    Key? key,
    required this.password,
    required this.strength,
  }) : super(key: key);

  final String password;
  final PasswordStrength strength;

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) {
        switch (strength) {
          case PasswordStrength.weak:
            return Text(
              lang.weakPassword,
              style: TextStyle(color: Theme.of(context).errorColor),
            );
          case PasswordStrength.moderate:
            return Text(lang.moderatePassword);
          case PasswordStrength.strong:
            return Text(
              lang.strongPassword,
              style: TextStyle(color: Theme.of(context).successColor),
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.check_circle, color: Theme.of(context).successColor);
  }
}
