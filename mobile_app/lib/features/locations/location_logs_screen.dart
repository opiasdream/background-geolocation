import 'dart:async';
import 'package:mobtestpackage/services/api/api_service.dart';
import 'package:mobtestpackage/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

part 'location_logs_screen_mixin.dart';

class LocationLogsScreen extends StatefulWidget {
  const LocationLogsScreen({super.key});

  @override
  State<LocationLogsScreen> createState() => _LocationLogsScreenState();

  static void go(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LocationLogsScreen()));
  }
}

class _LocationLogsScreenState extends State<LocationLogsScreen>
    with LocationLogsScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Logs")),
      body: Center(
        child: StreamBuilder(
          stream: streamController.stream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            } else {
              return SingleChildScrollView(child: Text(snapshot.data ?? ''));
            }
          },
        ),
      ),
    );
  }
}
