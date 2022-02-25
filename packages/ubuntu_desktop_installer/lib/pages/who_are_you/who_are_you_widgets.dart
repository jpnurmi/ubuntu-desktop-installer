part of 'who_are_you_page.dart';

class _RealNameFormField extends StatelessWidget {
  const _RealNameFormField({
    Key? key,
    required this.fieldWidth,
  }) : super(key: key);

  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final realName =
        context.select<WhoAreYouModel, String>((model) => model.realName);

    return ValidatedFormField(
      autofocus: true,
      fieldWidth: fieldWidth,
      labelText: lang.whoAreYouPageRealNameLabel,
      statusWidgetBuilder: (context, success) {
        return success ? const SuccessIcon() : null;
      },
      initialValue: realName,
      validator: RequiredValidator(
        errorText: lang.whoAreYouPageRealNameRequired,
      ),
      onChanged: (value) {
        final model = Provider.of<WhoAreYouModel>(context, listen: false);
        model.realName = value;
      },
    );
  }
}

class _HostnameFormField extends StatelessWidget {
  const _HostnameFormField({
    Key? key,
    this.fieldWidth,
  }) : super(key: key);

  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final hostname =
        context.select<WhoAreYouModel, String>((model) => model.hostname);

    return ValidatedFormField(
      fieldWidth: fieldWidth,
      labelText: lang.whoAreYouPageComputerNameLabel,
      helperText: lang.whoAreYouPageComputerNameInfo,
      statusWidgetBuilder: (context, success) {
        return success ? const SuccessIcon() : null;
      },
      initialValue: hostname,
      validator: MultiValidator([
        RequiredValidator(
          errorText: lang.whoAreYouPageComputerNameRequired,
        ),
        PatternValidator(
          kValidHostnamePattern,
          errorText: lang.whoAreYouPageInvalidComputerName,
        )
      ]),
      onChanged: (value) {
        final model = Provider.of<WhoAreYouModel>(context, listen: false);
        model.hostname = value;
      },
    );
  }
}

class _UsernameFormField extends StatelessWidget {
  const _UsernameFormField({
    Key? key,
    this.fieldWidth,
  }) : super(key: key);

  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final username =
        context.select<WhoAreYouModel, String>((model) => model.username);

    return ValidatedFormField(
      fieldWidth: fieldWidth,
      labelText: lang.whoAreYouPageUsernameLabel,
      statusWidgetBuilder: (context, success) {
        return success ? const SuccessIcon() : null;
      },
      initialValue: username,
      validator: MultiValidator([
        RequiredValidator(
          errorText: lang.whoAreYouPageUsernameRequired,
        ),
        PatternValidator(
          kValidUsernamePattern,
          errorText: lang.whoAreYouPageInvalidUsername,
        )
      ]),
      onChanged: (value) {
        final model = Provider.of<WhoAreYouModel>(context, listen: false);
        model.username = value;
      },
    );
  }
}

class _PasswordFormField extends StatelessWidget {
  const _PasswordFormField({
    Key? key,
    this.fieldWidth,
  }) : super(key: key);

  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final password =
        context.select<WhoAreYouModel, String>((model) => model.password);
    final passwordStrength = context.select<WhoAreYouModel, PasswordStrength>(
        (model) => model.passwordStrength);
    final showPassword =
        context.select<WhoAreYouModel, bool>((model) => model.showPassword);

    return ValidatedFormField(
      fieldWidth: fieldWidth,
      labelText: lang.whoAreYouPagePasswordLabel,
      obscureText: !showPassword,
      statusWidgetBuilder: (context, success) {
        return success
            ? PasswordStrengthLabel(strength: passwordStrength)
            : null;
      },
      initialValue: password,
      validator: RequiredValidator(
        errorText: lang.whoAreYouPagePasswordRequired,
      ),
      onChanged: (value) {
        final model = Provider.of<WhoAreYouModel>(context, listen: false);
        model.password = value;
      },
    );
  }
}

class _ConfirmPasswordFormField extends StatelessWidget {
  const _ConfirmPasswordFormField({
    Key? key,
    required this.fieldWidth,
  }) : super(key: key);

  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final password =
        context.select<WhoAreYouModel, String>((model) => model.password);
    final confirmedPassword = context
        .select<WhoAreYouModel, String>((model) => model.confirmedPassword);
    final showPassword =
        context.select<WhoAreYouModel, bool>((model) => model.showPassword);

    return ValidatedFormField(
      obscureText: !showPassword,
      fieldWidth: fieldWidth,
      labelText: lang.whoAreYouPageConfirmPasswordLabel,
      statusWidgetBuilder: (context, success) {
        return success && password.isNotEmpty ? const SuccessIcon() : null;
      },
      initialValue: confirmedPassword,
      autovalidateMode: AutovalidateMode.always,
      validator: EqualValidator(
        password,
        errorText: lang.whoAreYouPagePasswordMismatch,
      ),
      onChanged: (value) {
        final model = Provider.of<WhoAreYouModel>(context, listen: false);
        model.confirmedPassword = value;
      },
    );
  }
}

class _ShowPasswordCheckButton extends StatelessWidget {
  const _ShowPasswordCheckButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showPassword =
        context.select<WhoAreYouModel, bool>((model) => model.showPassword);

    return CheckButton(
      value: showPassword,
      title: const Text('Show password'),
      onChanged: (value) {
        final model = Provider.of<WhoAreYouModel>(context, listen: false);
        model.showPassword = value!;
      },
    );
  }
}

// class _LoginStrategyTile extends StatelessWidget {
//   const _LoginStrategyTile({
//     Key? key,
//     required this.value,
//     required this.label,
//   }) : super(key: key);

//   final LoginStrategy value;
//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     final loginStrategy = context
//         .select<WhoAreYouModel, LoginStrategy>((model) => model.loginStrategy);

//     return RadioButton<LoginStrategy>(
//       title: Text(label),
//       contentPadding: EdgeInsets.only(left: _kRadioButtonIndentation),
//       value: value,
//       groupValue: loginStrategy,
//       onChanged: (value) {
//         final model = Provider.of<WhoAreYouModel>(context, listen: false);
//         model.loginStrategy = value!;
//       },
//     );
//   }
// }
