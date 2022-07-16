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

  void updatePlanetGrid(int indexPlanet,int lastLvl){

   String modifiedGrid = planets[indexPlanet].gridMenu;
   int counter = 0;

   for(int i = 0; i < modifiedGrid.length && counter < lastLvl+1;i++){

     if(modifiedGrid[i] == "0" || modifiedGrid[i] == "2" || modifiedGrid[i] == "1"){

       if(counter != lastLvl) {
         modifiedGrid = modifiedGrid.substring(0, i) + "1" + modifiedGrid.substring(i+1, modifiedGrid.length);
       }else{
         modifiedGrid = modifiedGrid.substring(0, i) + "2" + modifiedGrid.substring(i+1, modifiedGrid.length);
       }
       counter++;
     }
   }

   planets[indexPlanet].gridMenu = modifiedGrid;
  }

}

class PlanetTheme {

  late Color color_1;
  late Color color_2;
  late Color no_color;

  late Color gradient_1;
  late Color gradient_2;

  late int position;

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
    position = theme["position"];

    no_color = const Color(0xFFD6D6D6);

    planet_path = theme["planet_path"];
    background_path = theme["background_path"];
    difficult = key[0].toUpperCase() + key.substring(1);
    gridMenu = theme["grid"];
  }
}