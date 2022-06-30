import 'dart:convert';

import 'package:flutter/material.dart';

class Themes {
  late List<PlanetTheme> planets;

  static final Themes instance = Themes._internal();

  factory Themes() {
    return instance;
  }

  void loadThemes(String configThemes) {

    Map<String, dynamic> themesJson = jsonDecode(configThemes);

    themesJson.forEach((key, value) {
      planets.add(PlanetTheme.fromString(key, value));
    });
  }

  PlanetTheme getTheme(int index) => planets[index];

  Themes._internal() {
    planets = [];
  }

}

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

  PlanetTheme.fromString(String key, Map<String, dynamic> theme) {

    color_1 = Color(int.parse(theme["color_1"], radix: 16));
    color_2 = Color(int.parse(theme["color_2"], radix: 16));
    gradient_1 = Color(int.parse(theme["gradient_1"], radix: 16));
    gradient_2 = Color(int.parse(theme["gradient_2"], radix: 16));

    no_color = const Color(0xFFD6D6D6);

    planet_path = theme["planet_path"];
    background_path = theme["background_path"];
    difficult = key[0].toUpperCase() + key.substring(1);
    gridMenu = theme["grid"];
  }
}