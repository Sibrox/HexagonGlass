import 'package:flutter/material.dart';

class HexagonTheme {
  late Color color_1;
  late Color color_2;
  late Color no_color;

  late Color gradient_1;
  late Color gradient_2;

  late String planet_path;
  late String background_path;
}

class MozillaTheme extends HexagonTheme {

  MozillaTheme() {
    color_1   = const Color(0xFFF7AF28);
    color_2   = const Color(0xFF00F4CF);
    no_color  = const Color(0xFFD6D6D6);

    gradient_1 = const Color(0xFFFFCB68);
    gradient_2 = const Color(0xFF920025);

    planet_path = "images/mozilla_planet.png";
    background_path = "images/mozilla_background.jpg";
  }
}

class DinoTheme extends HexagonTheme {

  DinoTheme() {
    color_1   = const Color(0xFF2CE295);
    color_2   = const Color(0xFFA66DDE);
    no_color  = const Color(0xFFD6D6D6);

    gradient_1 = const Color(0xFF4E8CAD);
    gradient_2 = const Color(0xFF2D3F8A);

    planet_path = "images/dino_planet.png";
    background_path = "images/dino_background.jpg";
  }

}
