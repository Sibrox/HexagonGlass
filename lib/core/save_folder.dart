import 'dart:convert';
import 'dart:io';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:path_provider/path_provider.dart';

class SaveFolder {
  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/status.json');
    if (!file.existsSync()) {
      await file.create(recursive: true);
    }

    return file;
  }

  static Future<Map<String, dynamic>> getSaveFile() async {
    File saveFile = await getFile();

    String stringInfo = saveFile.readAsStringSync();

    if (stringInfo.isEmpty) {
      Map<String, dynamic> initJson = {};

      initJson["player"] = {};
      initJson["player"]["tutorial"] = true;
      initJson["hexagon"] = {};
      initJson["hexagon"]["easy"] = {};
      initJson["hexagon"]["easy"]["level"] = 0;
      initJson["hexagon"]["easy"]["grid"] = Themes.instance.planets[0].gridMenu;

      initJson["hexagon"]["medium"] = {};
      initJson["hexagon"]["medium"]["level"] = 0;
      initJson["hexagon"]["medium"]["grid"] =
          Themes.instance.planets[1].gridMenu;
      initJson["hexagon"]["hard"] = {};
      initJson["hexagon"]["hard"]["level"] = 0;
      initJson["hexagon"]["hard"]["grid"] = Themes.instance.planets[2].gridMenu;

      saveFile.writeAsString(jsonEncode(initJson));

      return initJson;
    } else {
      Map<String, dynamic> infoJson = jsonDecode(stringInfo);
      return infoJson;
    }
  }

  static Future<void> updateFile(Map<String, dynamic> updatedJson) async {
    File saveFile = await getFile();
    saveFile.writeAsString(jsonEncode(updatedJson));
  }
}
