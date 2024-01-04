import 'dart:async';
import 'package:asriadtest/services/api/api_service.dart';
import 'package:flutter/material.dart';

class LocationLogsScreen extends StatefulWidget {
  const LocationLogsScreen({super.key});

  @override
  State<LocationLogsScreen> createState() => _LocationLogsScreenState();

  static void go(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LocationLogsScreen()));
  }
}

class _LocationLogsScreenState extends State<LocationLogsScreen> {
  final StreamController<String> streamController = StreamController<String>();
  late Timer timer;

  @override
  void initState() {
    fetchData();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchData();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    streamController.close();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await ApiService.fetchLocationLogs();
      if (response.statusCode == 200) {
        streamController.add(response.data.toString());
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      streamController.addError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Logs")),
      body: Center(
        child: StreamBuilder(
          stream: streamController.stream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
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
