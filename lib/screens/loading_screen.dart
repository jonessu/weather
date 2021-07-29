import 'package:project_8/screens/location_screen.dart';
import 'package:project_8/services/location.dart';
import 'package:flutter/material.dart';
import 'package:project_8/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_8/services/weather.dart';

const apiKey = '497c5dc0e24c3258c264d4ab05e2979b';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _getlocation();
  }

  void _getlocation() async {
    dynamic weatherdata = await WeatherModel().getlocationweather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherdata,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
