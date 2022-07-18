import 'dart:convert';

class Status{

  static final Status instance = Status._internal();
  late Map<String,dynamic> infoJson;

  factory Status(){
    return instance;
  }

  void loadStatus(String statusInfo){

    infoJson = jsonDecode(statusInfo);
  }

  void updateLvlStatus(String diff,int levelDone){
    String modifiedJson;
    //TODO: Need to add in the themes.json the type level: rectangle, hexagon ecc..
    infoJson["hexagon"][diff.toLowerCase()]["level"] = levelDone;
    modifiedJson = jsonEncode(infoJson);
    //rewrite file
  }

  int getLastLvl(String type,String diff){
    return infoJson[type][diff.toLowerCase()]["level"];
  }

  Status._internal();
}
