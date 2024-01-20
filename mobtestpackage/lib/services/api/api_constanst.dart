import 'dart:io';

class ApiConstants {
  ApiConstants._();

  /// Base url.
  static String get baseUrl =>
      Platform.isIOS ? "http://127.0.0.1:8000" : "http://10.0.2.2:8000";

  /// Add location url.
  static String get addLocationUrl => "$baseUrl/addLocation";

  /// All Location-Logs url.
  static String get locationLogsUrl => "$baseUrl/location-logs";

  /// Company Locations url.
  static String get companyLocationUrl => "$baseUrl/company-locations";
}
