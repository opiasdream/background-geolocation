part of 'home_screen.dart';

mixin HomeScreenMixin on State<HomeScreen> {
  final screenTitle = "Home Screen";

  /// Map options.
  final mapOptions = const MapOptions(
    initialCenter: LatLng(41.015941, 28.9784021),
    initialZoom: 9.2,
  );

  /// Tile layer for map.
  final tileLayer =
      TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png');

  late Future<List<Marker>> futureCompaniesList;

  @override
  void initState() {
    super.initState();
    futureCompaniesList = fetchData();
  }

  Future<List<Marker>> fetchData() async {
    List<Marker> aa = [];
    var response = await ApiService.fetchCompanyLocations();

    if (response.statusCode == 200) {
      var data = response.data as List;

      for (var element in data) {
        aa.add(
          Marker(
            rotate: true,
            point: LatLng(element['latitude'], element['longitude']),
            child: IconButton(
              onPressed: () => CompanyInfoDialog.show(
                  context: context, companyID: element['c-name']),
              icon: const Icon(Icons.location_on),
            ),
          ),
        );
      }
    }
    return aa;
  }
}
