import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  final defualtScheme = [0xFF364f6b, 0xFF3fc1c9, 0xFFf5f5f5, 0xFFfc5185];
  final altScheme = [0xFFf08a5d, 0xFFf9ed69, 0xFFb83b5e, 0xFF6a2c70];

  int primaryColor;
  int secondColor;
  int thirdColor;
  int fourthColor;
  Color textColor;

  ThemeProvider() {
    primaryColor = altScheme[0];
    secondColor = altScheme[1];
    thirdColor = altScheme[2];
    fourthColor = altScheme[3];
    textColor = Colors.grey[300];
  }
}
