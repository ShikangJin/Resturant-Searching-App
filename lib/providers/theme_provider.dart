import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  final defualtScheme = [0xFF364f6b, 0xFF3fc1c9, 0xFFf5f5f5, 0xFFfc5185];

  int primaryColor;
  int secondColor;
  int thirdColor;
  int fourthColor;

  ThemeProvider() {
    primaryColor = defualtScheme[0];
    secondColor = defualtScheme[1];
    thirdColor = defualtScheme[2];
    fourthColor = defualtScheme[3];
  }
}
