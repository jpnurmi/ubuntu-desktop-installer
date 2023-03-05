import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:provider/provider.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

/// Provides access to application-wide settings.
class Settings extends SafeChangeNotifier {
  /// Creates an app settings instance using the given GSettings as a backend
  /// for storing the settings.
  Settings(this._gsettings);

  final GSettings _gsettings;

  /// Returns settings for the given [context].
  ///
  /// Note: pass `listen: false` when applying settings without listening for
  /// changes (the entire app will be rebuilt anyway).
  static Settings of(BuildContext context, {bool listen = true}) {
    return Provider.of<Settings>(context, listen: listen);
  }

  /// Applies a theme matching the given [brightness].
  Future<void> applyTheme(Brightness brightness) async {
    final gtkTheme = (await _gsettings.get('gtk-theme')).asString();
    switch (brightness) {
      case Brightness.dark:
        await _gsettings.set(
            'gtk-theme', DBusString(gtkTheme.addSuffix('-dark')));
        await _gsettings.set('color-scheme', const DBusString('prefer-dark'));
        break;
      case Brightness.light:
        await _gsettings.set(
            'gtk-theme', DBusString(gtkTheme.removeSuffix('-dark')));
        await _gsettings.set('color-scheme', const DBusString('prefer-light'));
        break;
    }
  }

  /// The current application locale.
  Locale get locale => _locale;
  Locale _locale = WidgetsBinding.instance.window.locale;

  /// Applies the given [locale].
  void applyLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}

extension on String {
  String addSuffix(String suffix) {
    if (endsWith(suffix)) return this;
    return '$this$suffix';
  }

  String removeSuffix(String suffix) {
    if (!endsWith(suffix)) return this;
    return substring(0, length - suffix.length);
  }
}
