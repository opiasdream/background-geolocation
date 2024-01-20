import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobtestpackage/services/api/api_service.dart';
import 'package:mobtestpackage/widgets/loading_widget.dart';

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
      appBar: AppBar(title: Text(screenTitle)),
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

  FlutterMap mapWidget(List<Marker> markers) {
    return FlutterMap(
      options: mapOptions,
      children: [
        tileLayer,
        CurrentLocationLayer(
            style: LocationMarkerStyle(
          accuracyCircleColor: Colors.green.withOpacity(0.5),
          showAccuracyCircle: true,
        )),
        MarkerLayer(markers: markers),
      ],
    );
  }
}
