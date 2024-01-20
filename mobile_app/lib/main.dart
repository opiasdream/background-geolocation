import 'dart:io';
import 'package:mobtest/services/location/location_call_back.dart';
import 'package:mobtest/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';

void main() {
  runApp(const Root());

  if (Platform.isAndroid) {
    BackgroundGeolocation.registerHeadlessTask(headlessTask);
  }
}
