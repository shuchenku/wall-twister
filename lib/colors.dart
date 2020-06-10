import 'package:flutter/material.dart';

List<Color> getAllColors() {
  List<Color> allColors = new List();
  for (var i = 0; i<Colors.primaries.length; i = i+2) {
    allColors.add(Colors.primaries[i]);
  }
  allColors.add(Colors.white);
  allColors.add(Colors.black);
  allColors.add(Colors.pink);
  return allColors;
}

Color getColorFromString(String colorString) {
  String valueString = colorString.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return new Color(value);
}