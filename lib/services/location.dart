import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<Position> getCurrentLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }


    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high
    );
    Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    latitude = position.latitude;
    longitude = position.longitude;

    return await Geolocator.getCurrentPosition();
  }

}

