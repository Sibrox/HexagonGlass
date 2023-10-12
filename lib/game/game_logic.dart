part of 'game.dart';

extension Logic on Game {
  static bool checkRange(int i, int j, int nRow, int nCol) {
    return i >= 0 && j >= 0 && i < nRow && j < nCol;
  }

  static List<List<CellInfo>> buildRandomOrigin(int nRow, int nCol,
      [int? seed]) {
    var randomGenerator = Random(seed);

    List<List<CellInfo>> origin = [];
    for (int i = 0; i < nRow; i++) {
      origin.add([]);
      for (int j = 0; j < nCol; j++) {
        if (i % 2 != 0 && j == nCol - 1) {
          origin[i].add(CellInfo.random(0));
        } else {
          var rand = randomGenerator.nextInt(3);
          origin[i].add(CellInfo.random(rand));
        }
      }
    }

    return origin;
  }

  static List<List<CellInfo>> buildStatus(List<List<CellInfo>> origin) {
    List<List<CellInfo>> status = [];

    for (var (i, row) in origin.indexed) {
      status.add([]);
      for (var cellInfo in row) {
        status[i].add(CellInfo.buildFromOrigin(cellInfo));
      }
    }

    return status;
  }

  static List<List<CellInfo>> calculateValues(List<List<CellInfo>> origin) {
    List<List<CellInfo>> newOrigin = [];

    for (var (i, row) in origin.indexed) {
      newOrigin.add([]);
      for (var (j, cellInfo) in row.indexed) {
        newOrigin[i]
            .add(cellInfo.copyWith(value: calculateAdjValue(i, j, origin)));
      }
    }

    return newOrigin;
  }

  static int calculateAdjValue(int row, int col, List<List<CellInfo>> origin) {
    int counter = 0;
    int delta = row % 2 == 0 ? 0 : 1;
    CellColors currentColor = origin[row][col].color;

    List<List<int>> offset = [
      [-1, -1 + delta], // top - left
      [-1, 0 + delta], // top - right

      [0, -1], // left
      [0, 1], // right

      [1, -1 + delta], // bottom - left
      [1, 0 + delta], // bottom - right
    ];

    for (var [i, j] in offset) {
      counter +=
          checkRange(row + i, col + j, origin.length, origin[0].length) &&
                  origin[row + i][col + j].color == currentColor
              ? 1
              : 0;
    }

    return counter;
  }

  bool checkGame() {
    for (var (i, row) in origin.indexed) {
      for (var (j, originInfo) in row.indexed) {
        if (originInfo.isVisible == false) continue;

        CellInfo statusInfo = status[i][j];
        if (statusInfo.color == CellColors.grey) return false;
        if (statusInfo.color != originInfo.color) {
          return false;
        }

        // TODO: reverse
        // if (statusInfo.color == originInfo.color) {
        //   return false;
        // }
      }
    }

    return true;
  }
}
