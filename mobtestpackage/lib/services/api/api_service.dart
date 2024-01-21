import 'package:dio/dio.dart';
import 'package:mobtestpackage/services/api/api_constanst.dart';

class ApiService {
  ApiService._();

  static final _dio = Dio();

  /// Fetch location logs.
  static Future<Response> fetchLocationLogs() async {
    return await _dio.get(ApiConstants.locationLogsUrl);
  }

  /// Fetch company locations.
  static Future<Response> fetchCompanyLocations() async {
    return await _dio.get(ApiConstants.companyLocationUrl);
  }

  /// Fetch all notification logs.
  static Future<Response> fetchNotificationLogs() async {
    return await _dio.get(ApiConstants.notificatioLogsUrl);
  }

  /// Fetch client last location.
  static Future<Response> clientStreamLocation(String token) async {
    return await _dio.get(ApiConstants.clientLastLocationUrl,
        options: Options(headers: {"token": token}));
  }
}
