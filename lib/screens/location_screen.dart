import 'package:flutter/material.dart';
import 'package:project_8/utilities/constants.dart';
import 'package:project_8/services/weather.dart';
import 'city_screen.dart';

WeatherModel weather_model = WeatherModel();

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String city, condition, temprature, description;
  int temp;
  @override
  void initState() {
    super.initState();
    updateweather(widget.weatherData);
  }

  void updateweather(dynamic weatherData) {
    if (weatherData == null) {
      temprature = '0';
      condition = 'Error';
      description = "Unable to get weather Data!";
      city = '';
      return;
    }
    setState(() {
      temp = (weatherData['main']['temp']).round();
      temprature = temp.toString();
      description = weather_model.getMessage(temp);
      int condition_temp = (weatherData['weather'][0]['id']).round();
      condition = weather_model.getWeatherIcon(condition_temp);
      city = (weatherData['name']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      dynamic weatherData =
                          await weather_model.getlocationweather();
                      updateweather(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var citytext = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (citytext != null) {
                        dynamic weatherData =
                            await weather_model.getcityweather(citytext);
                        updateweather(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$description in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
