import 'dart:convert';

import 'package:flutter/material.dart';

class PlanetTheme {

  late Color color_1;
  late Color color_2;
  late Color no_color;

  late Color gradient_1;
  late Color gradient_2;

  late String planet_path;
  late String background_path;

  late String difficult;
  late String gridMenu;

  PlanetTheme() {}

  PlanetTheme.fromString(String themeString) {
    Map<String, dynamic> theme = jsonDecode(themeString);

    color_1 = const Color(0xFFFDB74E);
    color_2 = const Color(0xFF88E1FE);
    gradient_1 = const Color(0xFFF8BE50);
    gradient_2 = const Color(0xFF870202);

    no_color = const Color(0xFFD6D6D6);

    planet_path = theme["planet_path"];
    background_path = theme["background_path"];
    difficult = "Easy";
    gridMenu = "- 0 0 - \n 0 0 0 - \n- 0 0 - \n- - - - ";
  }


}

class MozillaTheme extends PlanetTheme {
  MozillaTheme() {
    color_1 = const Color(0xFFFDB74E);
    color_2 = const Color(0xFF88E1FE);
    gradient_1 = const Color(0xFFF8BE50);
    gradient_2 = const Color(0xFF870202);

    no_color = const Color(0xFFD6D6D6);

    planet_path = "images/planets/mozilla_planet.png";
    background_path = "images/background/mozilla_background_2.png";
    difficult = "Easy";
    gridMenu = "- 0 0 - \n 0 0 0 - \n- 0 0 - \n- 0 -  - ";
  }
}

class PinkTheme extends PlanetTheme {
  PinkTheme() {
    color_1 = const Color(0xFFFF75AD);
    color_2 = const Color(0xFFF8CCA4);
    gradient_1 = const Color(0xFFFFA7CE);
    gradient_2 = const Color(0xFFA42B24);

    no_color = const Color(0xFFD6D6D6);

    planet_path = "images/planets/pink_planet.png";
    background_path = "images/background/pink_background.jpg";

    difficult = "Medium";
    gridMenu = "0 0 0 0 \n 0 - 0 - \n- 0 0 - \n0 - 0 - ";
  }
}

class DinoTheme extends PlanetTheme {
  DinoTheme() {
    color_1 = const Color(0xFF2CE295);
    color_2 = const Color(0xFFA66DDE);
    gradient_1 = const Color(0xFF94C0D8);
    gradient_2 = const Color(0xFF2D3F8A);

    no_color = const Color(0xFFD6D6D6);

    planet_path = "images/planets/dino_planet.png";
    background_path = "images/background/dino_background.jpg";

    difficult = "Hard";
    gridMenu = "0 0 0 0 \n 0 - 0 - \n0 0 0 0 \n0 0 0 - ";
  }
}
