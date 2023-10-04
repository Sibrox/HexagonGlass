import 'cell_info.dart';

class Game {
  late int nRow, nCol;
  late List<List<CellInfo>> origin;
  late List<List<CellInfo>> game;

  Game.buildFromString(String serializedGame) {
    var rows = serializedGame.split('\n');
    nRow = rows.length;
    origin = [];
    game = [];

    for (var (i, row) in rows.indexed) {
      origin.add([]);
      game.add([]);

      var cellsInfo = row.split(" ");
      nCol = cellsInfo.length;
      for (var (j, cellInfo) in cellsInfo.indexed) {
        origin[i].add(CellInfo.fromString(cellInfo));
        game[i].add(CellInfo.buildFromOrigin(origin[i][j]));
      }
    }
  }
}
