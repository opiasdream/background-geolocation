flutter background geo-location with FastAPI

### requirements

#### for python
+ FastAPI
+ geopy

#### for fluter
+ look `pupspec.yaml` files

### installation

#### local_api
```
% cd local_api
% uvicorn main:app --reload
```
or
```
% cd local_api
uvicorn main:app  --reload --host 127.0.0.1 --port 8000
```

#### mobile_app
you can run `main.dart` on android or ios emulator.

switch to another terminal and then..

#### live_tracker_app
to avoid errors in cors operations:
```
% cd ..
% cd live_tracker_app 
% dart pub global activate flutter_cors 
% fluttercors --disable
```
you can run `main.dart` on web.

##### screenshots
![live tracker](screenshots/ss1.png)







