import 'dart:io';

import 'package:mobtest/services/api/api_constanst.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class LocationService {
  LocationService._();

  static void init() {
    bg.BackgroundGeolocation.ready(bg.Config(
            url: ApiConstants.addLocationUrl,
            notificationTitle: "Background tracking",
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 30.0,
            stopOnTerminate: false,
            startOnBoot: true,
            isMoving: true,
            debug: true,
            // if platform is android, headless will be enabled
            enableHeadless: Platform.isAndroid,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }
}
