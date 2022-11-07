import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SharedPreference {
  setSessionIdToLogin(sessionId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('session_id', sessionId);
  }

/*     setUserSessionIdToLogin(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  } */

  getSessionIdToLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id');
  }

  removeSessionIdToLogin() async {
    const String BASE_URL = "http://188.166.104.18:9011/";
    /*   var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }; */
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("$BASE_URL/web/session/destroy");
    var response = await http.post(url);
    if (response.statusCode == 200) {
      prefs.remove('session_id');
      print("Logout");
    }
  }
  
}
