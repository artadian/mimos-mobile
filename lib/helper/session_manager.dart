import 'package:mimos/PR/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String _isLogin = "is_login";
  final String _userid = "userid";
  final String _username = "username";
  final String _userroleid = "userroleid";
  final String _rolename = "rolename";
  final String _salesofficeid = "salesofficeid";
  final String _salesgroupid = "salesgroupid";
  final String _salesdistrictid = "salesdistrictid";
  final String _regionid = "regionid";
  final String _salesofficetype = "salesofficetype";
  final String _salesofficetypename = "salesofficetypename";
  final String _salesofficename = "salesofficename";
  final String _password = "password";

  SharedPreferences _prefsInstance;

  Future<SharedPreferences> get _instance async =>
      _prefsInstance ?? await SharedPreferences.getInstance();

  Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  Future<bool> createSession(User data, String pass) async {
    final prefs = await _instance;
    prefs.setBool(this._isLogin, true);
    prefs.setString(this._userid, data.userid);
    prefs.setString(this._username, data.username);
    prefs.setString(this._userroleid, data.userroleid);
    prefs.setString(this._rolename, data.rolename);
    prefs.setString(this._salesofficeid, data.salesofficeid);
    prefs.setString(this._salesgroupid, data.salesgroupid);
    prefs.setString(this._salesdistrictid, data.salesdistrictid);
    prefs.setString(this._regionid, data.regionid);
    prefs.setString(this._salesofficetype, data.salesofficetype);
    prefs.setString(this._salesofficetypename, data.salesofficetypename);
    prefs.setString(this._password, pass);

    return prefs.getBool(_isLogin);
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

  destroy() {
    return _prefsInstance.clear();
  }
}

var session = SessionManager();
