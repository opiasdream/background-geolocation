import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

@pragma('vm:entry-point')
void headlessTask(bg.HeadlessEvent headlessEvent) async {
  print('[BackgroundGeolocation HeadlessTask]: $headlessEvent');
  // Implement a 'case' for only those events you're interested in.
  switch (headlessEvent.name) {
    case bg.Event.TERMINATE:
      bg.State state = headlessEvent.event;
      print('- State: $state');
      break;
    case bg.Event.HEARTBEAT:
      bg.HeartbeatEvent event = headlessEvent.event;
      print('- HeartbeatEvent: $event');
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      print('- Location: $location');
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      print('- Location: $location');
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = headlessEvent.event;
      print('- GeofenceEvent: $geofenceEvent');
      break;
    case bg.Event.GEOFENCESCHANGE:
      bg.GeofencesChangeEvent event = headlessEvent.event;
      print('- GeofencesChangeEvent: $event');
      break;
    case bg.Event.SCHEDULE:
      bg.State state = headlessEvent.event;
      print('- State: $state');
      break;
    case bg.Event.ACTIVITYCHANGE:
      bg.ActivityChangeEvent event = headlessEvent.event;
      print('ActivityChangeEvent: $event');
      break;
    case bg.Event.HTTP:
      bg.HttpEvent response = headlessEvent.event;
      print('HttpEvent: $response');
      break;
    case bg.Event.POWERSAVECHANGE:
      bool enabled = headlessEvent.event;
      print('ProviderChangeEvent: $enabled');
      break;
    case bg.Event.CONNECTIVITYCHANGE:
      bg.ConnectivityChangeEvent event = headlessEvent.event;
      print('ConnectivityChangeEvent: $event');
      break;
    case bg.Event.ENABLEDCHANGE:
      bool enabled = headlessEvent.event;
      print('EnabledChangeEvent: $enabled');
      break;
  }
}

// /// Receive events from BackgroundFetch in Headless state.
// @pragma('vm:entry-point')
// void backgroundFetchHeadlessTask(HeadlessTask task) async {
//   String taskId = task.taskId;

//   // Is this a background_fetch timeout event?  If so, simply #finish and bail-out.
//   if (task.timeout) {
//     print("[BackgroundFetch] HeadlessTask TIMEOUT: $taskId");
//     BackgroundFetch.finish(taskId);
//     return;
//   }

//   print("[BackgroundFetch] HeadlessTask: $taskId");

//   try {
//     var location = await bg.BackgroundGeolocation.getCurrentPosition(
//         samples: 2, extras: {"event": "background-fetch", "headless": true});
//     print("[location] $location");
//   } catch (error) {
//     print("[location] ERROR: $error");
//   }

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   int count = 0;
//   if (prefs.get("fetch-count") != null) {
//     count = prefs.getInt("fetch-count")!;
//   }
//   prefs.setInt("fetch-count", ++count);
//   print('[BackgroundFetch] count: $count');

//   BackgroundFetch.finish(taskId);
// }
