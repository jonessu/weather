import 'package:project_8/services/networking.dart';
import 'package:project_8/services/location.dart';
import 'package:project_8/utilities/constants.dart';

class WeatherModel {
  dynamic getcityweather(String cityname) async {
    Location location = Location();
    await location.getlocation();
    NetworkHelper network =
        NetworkHelper(url: '$apitext?q=$cityname&appid=$apiKey&units=metric');
    dynamic weatherdata = await network.getdata();
    return weatherdata;
  }

  dynamic getlocationweather() async {
    Location location = Location();
    await location.getlocation();
    NetworkHelper network = NetworkHelper(
        url:
            '$apitext?lat=${location.latitude}&lon=${location.lontitude}&appid=$apiKey&units=metric');
    dynamic weatherdata = await network.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
