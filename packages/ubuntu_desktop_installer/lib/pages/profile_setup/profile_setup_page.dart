import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizard_router/wizard_router.dart';

import '../../constants.dart';
import '../../services.dart';
import '../../widgets.dart';
import '../wizard_page.dart';
import 'profile_setup_model.dart';

const _kContentWidthFactor = 0.75;

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({
    Key? key,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<UserService>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => ProfileSetupModel(service: service),
      child: ProfileSetupPage(),
    );
  }

  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final model = Provider.of<ProfileSetupModel>(context, listen: false);
    model.loadProfileSetup().then((_) {
      _usernameController.text = model.username;
    });

    _usernameController.addListener(() {
      model.username = _usernameController.text;
    });
    _passwordController.addListener(() {
      model.password = _passwordController.text;
    });
    _confirmPasswordController.addListener(() {
      model.confirmedPassword = _confirmPasswordController.text;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetupModel>(context);
    return LocalizedView(
      builder: (context, lang) {
        return WizardPage(
          contentPadding: EdgeInsets.zero,
          title: Text(lang.profileSetupTitle),
          header: Html(
            data: lang.profileSetupHeader,
            style: {'body': Style(margin: EdgeInsets.all(0))},
            onLinkTap: (url, _, __, ___) => launch(url!),
          ),
          content: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _kContentWidthFactor,
            child: ListView(
              children: <Widget>[
                _createTextField(
                  controller: _usernameController,
                  hintText: lang.profileSetupUsernameHint,
                  helperText: lang.profileSetupUsernameHelper,
                ),
                const SizedBox(height: kContentSpacing),
                _createTextField(
                  obscureText: true,
                  controller: _passwordController,
                  hintText: lang.profileSetupPasswordHint,
                ),
                _createTextField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  hintText: lang.profileSetupConfirmPasswordHint,
                ),
                const SizedBox(height: kContentSpacing),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CheckButton(
                    title: Text(lang.profileSetupShowAdvancedOptions),
                    value: model.showAdvancedOptions,
                    onChanged: (value) => model.showAdvancedOptions = value,
                  ),
                ),
              ],
            ),
          ),
          actions: <WizardAction>[
            WizardAction(
              label: lang.backButtonText,
              onActivated: Wizard.of(context).back,
            ),
            WizardAction(
              label: lang.continueButtonText,
              enabled: model.isValid,
              onActivated: Wizard.of(context).next,
            ),
          ],
        );
      },
    );
  }

  static Widget _createTextField({
    required TextEditingController controller,
    bool? obscureText,
    String? hintText,
    String? helperText,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kContentPadding.left),
      child: TextField(
        controller: controller,
        obscureText: obscureText == true,
        decoration: InputDecoration(hintText: hintText, helperText: helperText),
      ),
    );
  }
}
