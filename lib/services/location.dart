import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double lontitude;

  Future<void> getlocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      lontitude = position.longitude;
      print(position);
    } catch (e) {
      print(e);
    }
  }
}
