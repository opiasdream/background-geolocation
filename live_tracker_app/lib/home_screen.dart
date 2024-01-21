import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobtestpackage/constants/test_tokens.dart';
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List>(
                future: futureMarkers,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return mapWidget(snapshot.data!);
                  } else {
                    return const LoadingWidget();
                  }
                }),
          ),
          SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    chooseClientWidget(),
                    const Divider(),
                    lastLocationInfoWidget(),
                    const Divider(),
                    notificationsWidget()
                  ],
                ),
              )),
        ],
      ),
    );
  }

  FlutterMap mapWidget(List markers) {
    return FlutterMap(
      options: MapOptions(initialCenter: initialLocation),
      children: [
        TileLayer(urlTemplate: tileLayerUrl),
        CurrentLocationLayer(positionStream: streamClientLocation),
        MarkerLayer(markers: markers.first, rotate: true),
        CircleLayer(circles: markers.last)
      ],
    );
  }

  Row chooseClientWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("Client"),
        ValueListenableBuilder(
          valueListenable: testClientIsAndroid,
          builder: (context, value, child) {
            return SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text("android")),
                ButtonSegment(value: false, label: Text("ios")),
              ],
              selected:
                  testClientIsAndroid.value ? const {true} : const {false},
              showSelectedIcon: false,
              onSelectionChanged: (p0) => testClientIsAndroid.value = p0.first,
              multiSelectionEnabled: false,
            );
          },
        )
      ],
    );
  }

  Column lastLocationInfoWidget() {
    return Column(
      children: [
        const Text("Last Location"),
        ValueListenableBuilder(
            valueListenable: lastLocation,
            builder: (context, value, child) => Text(lastLocation.value)),
      ],
    );
  }

  Column notificationsWidget() {
    return Column(
      children: [
        const Text("Notifications"),
        StreamBuilder(
          stream: streamNotifications,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else {
              return const LoadingWidget();
            }
          },
        )
      ],
    );
  }
}
