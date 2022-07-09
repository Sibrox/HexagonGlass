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

  Status._internal();
}