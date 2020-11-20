import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class Connection {

  static Future<bool> isConnectedToInternet() async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    // user is connected via wifi or mobile data
    if (connectivityResult != ConnectivityResult.none) {
      return await DataConnectionChecker().hasConnection;
    }
    return false;
  }
}