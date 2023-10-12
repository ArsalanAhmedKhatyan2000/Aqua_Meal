import 'package:shared_preferences/shared_preferences.dart';

enum UserPref {
  authToken,
}

class SharedPreferencesHelper {
  Future<bool> setAuthToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(UserPref.authToken.toString(), token);
  }

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(UserPref.authToken.toString());
  }

  Future<bool> removeAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(UserPref.authToken.toString());
  }
}
