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
}