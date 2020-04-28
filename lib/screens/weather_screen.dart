import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/screens/location_screen.dart';

final apiKey = { API key }; // from openweathermap.org

class WeatherScreen extends StatefulWidget {
  final String city;
  WeatherScreen({Key key, @required this.city}) : super(key: key);
  @override
  _WeatherScreenState createState() => _WeatherScreenState(city);
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city;
  _WeatherScreenState(this.city);

  Future fetchData(String city) async {
    print("start fetch !");
    String url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city,uk&APPID=$apiKey";
    http.Response response = await http.get(url);
    //status codes : 200 success, 404 city not found, 401 invalid API key
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Weather.getWeather(json);
    } else {
      print("Not found");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: this.fetchData(city),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return snapshot.data == null
                    ? Container(
                        child: Center(
                          child: Text(
                            "City Not Found.",
                            style: TextStyle(
                                fontFamily: "Spartan",
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : getLocationScreen(snapshot.data);
            }
          },
        ),
      ),
    );
  }

  Widget getLocationScreen(Weather location) {
    List<IconData> gridIcons = [
      FontAwesomeIcons.thermometerThreeQuarters,
      FontAwesomeIcons.temperatureLow,
      FontAwesomeIcons.temperatureHigh,
      FontAwesomeIcons.tachometerAlt,
      FontAwesomeIcons.tint,
      FontAwesomeIcons.wind
    ];
    List<String> gridHeaders = [
      'Feels like',
      'Temp min',
      'Temp max',
      'Pressure',
      'Humidity',
      'Wind'
    ];
    List<String> gridValues = [
      location.feelsLike,
      location.tempMin,
      location.tempMax,
      location.pressure,
      location.humidity,
      location.windspeed
    ];

    Color screenColor = colorList[Random().nextInt(colorList.length)];

    return Container(
      decoration: getScreenDecoration(screenColor),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        city = city;
                      });
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      location.city,
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 30,
                          letterSpacing: 1.6),
                    ),
                    Text(
                      location.country,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.grey[300]),
                    ),
                  ],
                ),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.searchLocation,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationScreen()));
                    }),
              ],
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      location.temp,
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 90,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          descList[location.description],
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          location.description,
                          style: TextStyle(
                              fontFamily: 'Spartan',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(
                    6,
                    (index) => Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: screenColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            gridIcons[index],
                          ),
                          Text(
                            gridHeaders[index],
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: Colors.grey[300]),
                          ),
                          Text(
                            gridValues[index],
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
