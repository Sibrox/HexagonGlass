import 'package:xml/xml.dart';

class Game {
  final int gameID;
  final String gameName;
  final int minPlayer;
  final int maxPlayer;
  final int age;

  Game(this.gameID, this.gameName, this.minPlayer, this.maxPlayer, this.age);
}
