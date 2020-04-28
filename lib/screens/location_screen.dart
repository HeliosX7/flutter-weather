import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/screens/weather_screen.dart';
import 'package:weather/utilities/constants.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: getScreenDecoration(Colors.teal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.cloudversify,
              size: 90,
            ),
            Text(
              "Get Weather.",
              style: TextStyle(
                  fontFamily: "Spartan",
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextField(
                controller: textFieldController,
                decoration: InputDecoration(
                  labelText: "Enter City :  ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
              ),
            ),
            RaisedButton(
              elevation: 0.0,
              color: Colors.transparent,
              onPressed: () {
                String city = textFieldController.text;
                if (city != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeatherScreen(
                                city: city,
                              )));
                }
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.teal.withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "SEARCH",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
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
