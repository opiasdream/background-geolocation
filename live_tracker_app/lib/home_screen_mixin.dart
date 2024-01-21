part of 'home_screen.dart';

mixin HomeScreenMixin on State<HomeScreen> {
  final screenTitle = "Live Tracking";

  final initialLocation = const LatLng(41.015941, 28.9784021);
  final tileLayerUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";

  late Future<List> futureMarkers;
  Stream<String?>? streamNotifications;
  Stream<LocationMarkerPosition?>? streamClientLocation;

  ValueNotifier<bool> testClientIsAndroid = ValueNotifier<bool>(true);
  ValueNotifier<String> lastLocation = ValueNotifier<String>("");
  ValueNotifier<String> token = ValueNotifier<String>(TestTokens.androidToken);

  @override
  void initState() {
    futureMarkers = getMarkers();
    streamNotifications = _streamNotifications();
    streamClientLocation = _streamClientLocation();

    testClientIsAndroid.addListener(() {
      token.value = testClientIsAndroid.value
          ? TestTokens.androidToken
          : TestTokens.iosToken;
    });
    super.initState();
  }

  @override
  void dispose() {
    screenTitle;
    futureMarkers;
    streamClientLocation;
    testClientIsAndroid.dispose();
    lastLocation.dispose();
    token.dispose();
    super.dispose();
  }

  Future<List> getMarkers() async {
    List<Marker> companies = [];
    List<CircleMarker> circles = [];
    try {
      var response = await ApiService.fetchCompanyLocations();

      if (response.statusCode == 200) {
        var data = response.data as List;

        for (var element in data) {
          companies.add(
            Marker(
              point: LatLng(element['latitude'], element['longitude']),
              child: const Icon(Icons.location_on),
            ),
          );
          circles.add(
            CircleMarker(
              point: LatLng(element['latitude'], element['longitude']),
              borderColor: Colors.blue,
              color: Colors.blue.withOpacity(.2),
              useRadiusInMeter: true,
              radius: 1000,
            ),
          );
        }
      }
    } catch (e) {
      rethrow;
    }
    return [companies, circles];
  }

  Stream<String?>? _streamNotifications() async* {
    while (true) {
      var response = await ApiService.fetchNotificationLogs();

      yield response.data.toString();

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Stream<LocationMarkerPosition?>? _streamClientLocation() async* {
    LocationMarkerPosition? position;

    while (true) {
      var response = await ApiService.clientStreamLocation(token.value);

      Map<String, dynamic> json = jsonDecode(response.data);

      Map data = json["location"]["coords"];

      position = LocationMarkerPosition(
        latitude: double.parse(data['latitude'].toString()),
        longitude: double.parse(data['longitude'].toString()),
        accuracy: double.parse(data['accuracy'].toString()),
      );

      lastLocation.value = '${token.value} *** $position';

      yield position;

      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
