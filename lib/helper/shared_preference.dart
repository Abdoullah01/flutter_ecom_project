import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  setSessionIdToLogin(sessionId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('session_id', sessionId);
  }

  getSessionIdToLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id')!;
  }

  removeSessionIdToLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('session_id');
  }
}
