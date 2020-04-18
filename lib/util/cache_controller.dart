import 'package:shared_preferences/shared_preferences.dart';

import 'errors.dart';

class CacheController {
  final SharedPreferences sharedPreferences;

  CacheController({this.sharedPreferences});

  Future<dynamic> readKey(String key) async {
    final value = sharedPreferences.getString(key);
    if (value != null) {
      return Future.value(value);
    } else {
      return CacheError();
    }
  }

  Future<void> writeKey(String key, String value) async {
    return sharedPreferences.setString(key, value);
  }

  Future<void> deleteKey(String key) async {
    sharedPreferences.remove(key);
  }
}
