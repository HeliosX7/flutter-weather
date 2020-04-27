import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Color> colorList = [
  Colors.pink,
  Colors.red,
  Colors.orange,
  Colors.amber,
  Colors.yellow,
  Colors.lime,
  Colors.green,
  Colors.teal,
  Colors.cyan,
  Colors.blue,
  Colors.purple,
  Colors.brown,
];

Map<String, IconData> descList = {
  'Clouds': FontAwesomeIcons.cloud,
  'Rain': FontAwesomeIcons.cloudRain,
  'Snow': FontAwesomeIcons.snowflake,
  'Drizzle': FontAwesomeIcons.cloudShowersHeavy,
};

BoxDecoration getScreenDecoration(screenColor) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        screenColor[500],
        screenColor[400],
        screenColor[300],
        screenColor[200],
      ],
    ),
  );
}
