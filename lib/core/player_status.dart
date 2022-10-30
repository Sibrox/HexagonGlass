import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/save_folder.dart';

class Status {
  static final Status instance = Status._internal();
  late Map<String, dynamic> infoJson;
  List<String> grids = [];

  factory Status() {
    return instance;
  }

  void loadStatus(Map<String, dynamic> json) {
    infoJson = json;

    grids.add(infoJson["hexagon"]["easy"]["grid"]);
    grids.add(infoJson["hexagon"]["medium"]["grid"]);
    grids.add(infoJson["hexagon"]["hard"]["grid"]);
  }

  Future<void> updateLvlStatus(String diff, int levelDone, int index) async {
    if (levelDone > infoJson["hexagon"][diff.toLowerCase()]["level"]) {
      infoJson["hexagon"][diff.toLowerCase()]["level"] = levelDone;
      updatePlanetGrid(index, levelDone);
    }

    infoJson["hexagon"][diff.toLowerCase()]["grid"] = grids[index];

    await SaveFolder.updateFile(infoJson);
  }

  bool planetCompleted(String type, String diff, int lastLevel) {
    return infoJson[type][diff.toLowerCase()]["level"] == lastLevel;
  }

  Map<String, dynamic> getInfoJson() {
    return infoJson;
  }

  String getGrid(int index) {
    return grids[index];
  }

  void updatePlanetGrid(int indexPlanet, int lastLvl) {
    String modifiedGrid = grids[indexPlanet];
    int counter = 0;

    for (int i = 0; i < modifiedGrid.length && counter < lastLvl + 1; i++) {
      if (modifiedGrid[i] == "0" ||
          modifiedGrid[i] == "2" ||
          modifiedGrid[i] == "1") {
        if (counter != lastLvl) {
          modifiedGrid = modifiedGrid.substring(0, i) +
              "1" +
              modifiedGrid.substring(i + 1, modifiedGrid.length);
        } else {
          modifiedGrid = modifiedGrid.substring(0, i) +
              "2" +
              modifiedGrid.substring(i + 1, modifiedGrid.length);
        }
        counter++;
      }
    }

    grids[indexPlanet] = modifiedGrid;
  }

  Status._internal();
}
