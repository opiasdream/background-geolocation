import 'package:mobtest/features/home/home_screen.dart';
import 'package:mobtest/services/location/location_service.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    LocationService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Mobile Test', home: HomeScreen());
  }
}
