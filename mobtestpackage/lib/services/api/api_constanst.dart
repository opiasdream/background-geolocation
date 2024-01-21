import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConstants {
  ApiConstants._();

  /// Base url.
  static String get baseUrl => kIsWeb || Platform.isIOS
      ? "http://127.0.0.1:8000"
      : "http://10.0.2.2:8000";

  /// Add location url.
  static String get addLocationUrl => "$baseUrl/addLocation";

  /// All Location-Logs url.
  static String get locationLogsUrl => "$baseUrl/location-logs";

  /// Company Locations url.
  static String get companyLocationUrl => "$baseUrl/company-locations";

  /// All notification logs url.
  static String get notificatioLogsUrl => "$baseUrl/notification-logs";

  /// Client Last Location url.
  static String get clientLastLocationUrl => "$baseUrl/client-last-location";
}
