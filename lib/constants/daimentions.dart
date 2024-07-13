import 'package:flutter/material.dart';

class Daimentions {
  BuildContext context;
  Daimentions({required this.context});
  // Dimensions in physical pixels (px)
  late double width = MediaQuery.of(context).size.height;
  late double height = MediaQuery.of(context).size.height;

// Daimentions in height
  late double Height5 = height / 156;
  late double Height10 = height / 78;
  late double Height20 = height / 37;
  late double Height25 = height / 31.5;
  late double Height30 = height / 26;
  late double Height40 = height / 19.5;

// Daimentions in width
  late double Width5 = width / 72;

  late double Width10 = width / 36;
  late double Width20 = width / 18;
  late double Width25 = width / 15.4;
}
