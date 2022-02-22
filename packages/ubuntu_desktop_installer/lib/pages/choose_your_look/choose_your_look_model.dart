import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:subiquity_client/subiquity_client.dart';

class ChooseYourLookModel extends ChangeNotifier {
  ChooseYourLookModel(this._client);

  final SubiquityClient _client; // ignore: unused_field

  Future<void> save(Brightness brightness) async {
    return _client.copyFiles(
      source: '/schemas/',
      target: '/usr/share/glib-2.0/schemas/',
    );
  }

  String _resolveAsset(String fileName) {
    final appdir = p.dirname(Platform.resolvedExecutable);
    return p.join(appdir, 'data', 'flutter_assets', 'schemas', fileName);
  }
}
