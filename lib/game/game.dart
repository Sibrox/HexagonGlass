import 'package:flutter/foundation.dart';

import 'cell_info.dart';

class Game {
  late int nRow, nCol;
  late List<List<CellInfo>> origin;
  late List<List<CellInfo>> status;

  Game(
      {required this.origin,
      required this.status,
      required this.nRow,
      required this.nCol});

  Game.buildFromString(String serializedGame) {
    var rows = serializedGame.split('\n');
    nRow = rows.length;
    origin = [];
    status = [];

    for (var (i, row) in rows.indexed) {
      origin.add([]);
      status.add([]);

      var cellsInfo = row.split(" ");
      nCol = cellsInfo.length;
      for (var (j, cellInfo) in cellsInfo.indexed) {
        origin[i].add(CellInfo.fromString(cellInfo));
        status[i].add(CellInfo.buildFromOrigin(origin[i][j]));
      }
    }
  }

  Game buildFromOrigin() {
    nRow = origin.length;
    nCol = origin[0].length;

    List<List<CellInfo>> changeGame = [];
    for (var (i, row) in origin.indexed) {
      changeGame.add([]);
      for (var cellInfo in row) {
        changeGame[i].add(CellInfo.buildFromOrigin(cellInfo));
      }
    }
    return Game(
        nRow: nRow, nCol: nCol, origin: List.from(origin), status: changeGame);
  }

  Game generateFromClick(int i, int j) {
    List<List<CellInfo>> changeGame = List.from(status);
    changeGame[i][j].toggle();
    return Game(
        nRow: nRow, nCol: nCol, origin: List.from(origin), status: changeGame);
  }

  @override
  bool operator ==(Object other) {
    Game otherGame = (other as Game);
    if (otherGame.status.length != status.length) return false;

    for (var (i, _) in status.indexed) {
      if (!listEquals(status[i], otherGame.status[i])) return false;
    }
    return true;
  }

  @override
  int get hashCode => status.hashCode;
}
