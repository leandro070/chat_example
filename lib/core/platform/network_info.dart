import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loggy/loggy.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl with UiLoggy implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    loggy.debug('IsConnected=$isConnected');
    return isConnected;
  }
}
