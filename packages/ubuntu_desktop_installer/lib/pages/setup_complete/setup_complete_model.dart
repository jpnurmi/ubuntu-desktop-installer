import 'package:flutter/foundation.dart';

import '../../services.dart';

class SetupCompleteModel extends ChangeNotifier {
  SetupCompleteModel({required UserService service}) : _service = service {
    _username.addListener(notifyListeners);
    init();
  }

  final UserService _service;

  String get username => _username.value;
  final _username = ValueNotifier<String>('');

  Future<void> init() {
    return _service.fetchUsername().then((value) => _username.value = value);
  }
}
