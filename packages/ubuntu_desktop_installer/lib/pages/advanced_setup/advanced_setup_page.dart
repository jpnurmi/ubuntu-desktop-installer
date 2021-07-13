import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../routes.dart';
import '../../widgets.dart';
import '../wizard_page.dart';
import 'advanced_setup_model.dart';

const _kContentWidthFactor = 0.75;

class AdvancedSetupPage extends StatefulWidget {
  const AdvancedSetupPage({
    Key? key,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdvancedSetupModel(),
      child: AdvancedSetupPage(),
    );
  }

  @override
  _AdvancedSetupPageState createState() => _AdvancedSetupPageState();
}

class _AdvancedSetupPageState extends State<AdvancedSetupPage> {
  final _mountLocationController = TextEditingController();
  final _mountOptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final model = Provider.of<AdvancedSetupModel>(context, listen: false);
    model.loadAdvancedSetup().then((_) {
      _mountLocationController.text = model.mountLocation;
      _mountOptionController.text = model.mountOption;
    });

    _mountLocationController.addListener(() {
      model.mountLocation = _mountLocationController.text;
    });
    _mountOptionController.addListener(() {
      model.mountOption = _mountOptionController.text;
    });
  }

  @override
  void dispose() {
    _mountLocationController.dispose();
    _mountOptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AdvancedSetupModel>(context);
    return LocalizedView(
      builder: (context, lang) {
        return WizardPage(
          contentPadding: EdgeInsets.zero,
          title: Text(lang.advancedSetupTitle),
          header: Text(lang.advancedSetupHeader),
          content: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _kContentWidthFactor,
            child: ListView(
              children: <Widget>[
                _createTextField(
                  controller: _mountLocationController,
                  hintText: lang.advancedSetupMountLocationHint,
                  helperText: lang.advancedSetupMountLocationHelper,
                ),
                const SizedBox(height: 8), // TODO: constant?
                _createTextField(
                  obscureText: true,
                  controller: _mountOptionController,
                  hintText: lang.advancedSetupMountOptionHint,
                  helperText: lang.advancedSetupMountOptionHelper,
                ),
                const SizedBox(height: kContentSpacing),
                CheckButton(
                  title: Text(lang.advancedSetupHostGenerationTitle),
                  subtitle: Text(lang.advancedSetupHostGenerationSubtitle),
                  value: model.enableHostGeneration,
                  onChanged: (value) => model.enableHostGeneration = value,
                ),
                CheckButton(
                  title: Text(lang.advancedSetupResolvConfGenerationTitle),
                  subtitle:
                      Text(lang.advancedSetupResolvConfGenerationSubtitle),
                  value: model.enableResolvConfGeneration,
                  onChanged: (value) =>
                      model.enableResolvConfGeneration = value,
                ),
                CheckButton(
                  title: Text(lang.advancedSetupGUIIntegrationTitle),
                  subtitle: Text(lang.advancedSetupGUIIntegrationSubtitle),
                  value: model.enableGUIIntegration,
                  onChanged: (value) => model.enableGUIIntegration = value,
                ),
              ],
            ),
          ),
          actions: <WizardAction>[
            WizardAction(
              label: lang.backButtonText,
              onActivated: Navigator.of(context).pop,
            ),
            WizardAction(
              label: lang.continueButtonText,
              enabled: model.isValid,
              onActivated: () {
                Navigator.pushNamed(context, Routes.configurationUI);
              },
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
