import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../routes.dart';
import '../../widgets.dart';
import '../wizard_page.dart';
import 'configuration_ui_model.dart';

const _kContentWidthFactor = 0.75;

class ConfigurationUIPage extends StatefulWidget {
  const ConfigurationUIPage({
    Key? key,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConfigurationUIModel(),
      child: ConfigurationUIPage(),
    );
  }

  @override
  _ConfigurationUIPageState createState() => _ConfigurationUIPageState();
}

class _ConfigurationUIPageState extends State<ConfigurationUIPage> {
  @override
  void initState() {
    super.initState();

    final model = Provider.of<ConfigurationUIModel>(context, listen: false);
    model.loadUIConfiguration().then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ConfigurationUIModel>(context);
    return LocalizedView(
      builder: (context, lang) {
        return WizardPage(
          title: Text(lang.configurationUITitle),
          headerPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _kContentWidthFactor,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: kHeaderPadding,
                  child: Text(lang.configurationUIInteroperabilityHeader),
                ),
                CheckButton(
                  title: Text(lang.configurationUILegacyGUIIntegrationTitle),
                  subtitle:
                      Text(lang.configurationUILegacyGUIIntegrationSubtitle),
                  value: model.legacyGUI,
                  onChanged: (value) => model.legacyGUI = value,
                ),
                CheckButton(
                  title: Text(lang.configurationUILegacyAudioIntegrationTitle),
                  subtitle:
                      Text(lang.configurationUILegacyAudioIntegrationSubtitle),
                  value: model.legacyAudio,
                  onChanged: (value) => model.legacyAudio = value,
                ),
                CheckButton(
                  title: Text(lang.configurationUIAdvancedIPDetectionTitle),
                  subtitle:
                      Text(lang.configurationUIAdvancedIPDetectionSubtitle),
                  value: model.advancedIPDetection,
                  onChanged: (value) => model.advancedIPDetection = value,
                ),
                Padding(
                  padding: kHeaderPadding,
                  child: Text(lang.configurationUIMessageOfTheDayHeader),
                ),
                CheckButton(
                  title: Text(lang.configurationUIWSLNewsTitle),
                  subtitle: Text(lang.configurationUIWSLNewsSubtitle),
                  value: model.wslNews,
                  onChanged: (value) => model.wslNews = value,
                ),
                Padding(
                  padding: kHeaderPadding,
                  child: Text(lang.configurationUIAutoMountHeader),
                ),
                CheckButton(
                  title: Text(lang.configurationUIAutoMountTitle),
                  subtitle: Text(lang.configurationUIAutoMountSubtitle),
                  value: model.autoMount,
                  onChanged: (value) => model.autoMount = value,
                ),
                CheckButton(
                  title: Text(lang.configurationUIMountFstabTitle),
                  subtitle: Text(lang.configurationUIMountFstabSubtitle),
                  value: model.mountFstab,
                  onChanged: (value) => model.mountFstab = value,
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
                Navigator.pushNamed(context, Routes.setupComplete);
              },
            ),
          ],
        );
      },
    );
  }
}
