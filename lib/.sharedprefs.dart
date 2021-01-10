import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  //
  Future<int> getInt(String input) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(input)) {
      final _input = prefs.getInt(input);
      return _input;
    } else {
      return 0;
    }
  }

  Future<String> getString(input) async {
    final prefs = await SharedPreferences.getInstance();
    final _input = prefs.getString(input);
    if (_input == null) {
      return "";
    } else {
      return _input;
    }
  }

  Future<bool> getBool(input) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(input)) {
      final _input = prefs.getBool(input);
      return _input;
    } else {
      return false;
    }
  }

  Future<void> setInt(input, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(input, value);
  }

  Future<void> setString(input, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(input, value);
  }

  Future<void> setBool(input, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(input, value);
  }

  Future<void> startCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int letzteStartNummer = await getInt("startNummer");
    int aktuelleStartNummer = ++letzteStartNummer;
    await prefs.setInt("startNummer", aktuelleStartNummer);
  }
}
