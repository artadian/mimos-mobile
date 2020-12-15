
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String _userid = "userid";
  final String _username = "username";
  final String _userroleid = "userroleid";
  final String _rolename = "rolename";
  final String _salesofficeid = "salesofficeid";
  final String _salesofficename = "salesofficename";

  SharedPreferences _prefsInstance;

  Future<SharedPreferences> get _instance async =>
      _prefsInstance ?? await SharedPreferences.getInstance();

  Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  String getString(String key, [String defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  bool getBool(String key, [bool defValue]) {
    return _prefsInstance.getBool(key) ?? defValue ?? false;
  }

  Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(key, value) ?? Future.value(false);
  }

  int getInt(String key, [int defValue]) {
    return _prefsInstance.getInt(key) ?? defValue;
  }

  Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs?.setInt(key, value) ?? Future.value(false);
  }

  String userId() => getString(_userid);
  String username() => getString(_username);
  String userRoleId() => getString(_userroleid);
  String roleName() => getString(_rolename);
  String salesOfficeId() => getString(_salesofficeid);
  String salesOfficeName() => getString(_salesofficename);

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userid) ?? null;
  }

  Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userid, value);
  }

}

var session = SessionManager();