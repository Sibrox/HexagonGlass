import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hexagon_glass/game/cell_colors.dart';

import 'cell_info.dart';

part 'game_logic.dart';

class Game extends Equatable {
  final int nRow, nCol;
  final List<List<CellInfo>> origin;
  final List<List<CellInfo>> status;

  const Game(
      {required this.origin,
      required this.status,
      required this.nRow,
      required this.nCol});

  factory Game.buildFromString(String serializedGame) {
    var rows = serializedGame.split('\n');

    var nCol = 0;
    var nRow = rows.length;

    List<List<CellInfo>> origin = [];
    for (var (i, row) in rows.indexed) {
      origin.add([]);

      var cellsInfo = row.split(" ");

      nCol = cellsInfo.length;
      for (var (_, cellInfo) in cellsInfo.indexed) {
        origin[i].add(CellInfo.fromString(cellInfo));
      }
    }

    origin = Logic.calculateValues(origin);

    List<List<CellInfo>> status = [];
    for (var (i, row) in origin.indexed) {
      status.add([]);

      for (var (_, originInfo) in row.indexed) {
        status[i].add(CellInfo.buildFromOrigin(originInfo));
      }
    }

    return Game(nCol: nCol, nRow: nRow, origin: origin, status: status);
  }

  factory Game.buildFromOrigin(List<List<CellInfo>> origin) {
    var nRow = origin.length;
    var nCol = origin[0].length;

    List<List<CellInfo>> status = Logic.buildStatus(origin);
    return Game(
        nRow: nRow, nCol: nCol, origin: List.from(origin), status: status);
  }

  factory Game.generateFromClick(Game currentState, int i, int j) {
    List<List<CellInfo>> changeGame =
        List.from(currentState.status.map((list) => List<CellInfo>.from(list)));
    changeGame[i][j] = changeGame[i][j].toggle();

    return Game(
        nRow: currentState.nRow,
        nCol: currentState.nCol,
        origin: currentState.origin,
        status: changeGame);
  }

  factory Game.random(int nRow, int nCol, [int? seed]) {
    List<List<CellInfo>> origin = Logic.buildRandomOrigin(nRow, nCol);
    origin = Logic.calculateValues(origin);
    List<List<CellInfo>> status = Logic.buildStatus(origin);

    return Game(nCol: nCol, nRow: nRow, origin: origin, status: status);
  }

  Game copyWith({nCol, nRow, origin, status}) {
    return Game(
        nCol: nCol ?? this.nCol,
        nRow: nRow ?? this.nRow,
        origin: origin ?? this.origin,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [nCol, nRow, origin, status];
}
