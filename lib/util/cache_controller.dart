import 'package:shared_preferences/shared_preferences.dart';

import 'errors.dart';

const AUTH_CACHE_KEY = 'Auth_key';
const USER_CACHE_KEY = 'User_key';
const CUR_COMP_CACHE_KEY = 'Current_company_key';

class CacheController {
  final SharedPreferences sharedPreferences;

  CacheController({this.sharedPreferences});

  Future<String> readKey(String key) async {
    final value = sharedPreferences.getString(key);
    if (value == null) {
      throw CacheException();
    } else {
      return Future.value(value);
    }
  }

  Future<void> writeKey(String key, String value) async {
    return sharedPreferences.setString(key, value);
  }

  Future<void> deleteKey(String key) async {
    sharedPreferences.remove(key);
  }
}
