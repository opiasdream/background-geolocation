import 'package:asriadtest/common/widgets/loading_widget.dart';
import 'package:asriadtest/features/home/company_info_dialog.dart';
import 'package:asriadtest/features/locations/location_logs_screen.dart';
import 'package:asriadtest/services/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

part 'home_screen_mixin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: FutureBuilder(
          future: futureCompaniesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return mapWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const LoadingWidget();
            }
          }),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(screenTitle),
      actions: [
        IconButton(
            onPressed: () => LocationLogsScreen.go(context),
            icon: const Icon(Icons.turn_sharp_left))
      ],
    );
  }

  FlutterMap mapWidget(List<Marker> markers) {
    return FlutterMap(
      options: mapOptions,
      children: [
        tileLayer,
        CurrentLocationLayer(),
        MarkerLayer(markers: markers),
      ],
    );
  }
}
