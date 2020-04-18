import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfo(this.connectionChecker);

  Future<bool> get isConnected async {
    bool _isConnected = await connectionChecker.hasConnection;
    if (!_isConnected) {
      print('No internet connection!');
    }
    return _isConnected;
  }
}
