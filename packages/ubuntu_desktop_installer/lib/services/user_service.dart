class UserService {
  String _username = '';
  Future<String> fetchUsername() async => _username;
  Future<void> storeUsername(String username) async => _username = username;
}
