part of "location_logs_screen.dart";

mixin LocationLogsScreenMixin on State<LocationLogsScreen> {
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
}
