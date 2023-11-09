import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();
  late SharedPreferences _prefs;
  String? _token;

  factory TokenManager() {
    return _instance;
  }

  TokenManager._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString('accessToken');
  }

  String? get token => _token;

  void setToken(String value) {
    _token = value;
    _prefs.setString('accessToken', value);
  }

}
