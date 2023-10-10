part of 'game.dart';

extension Logic on Game {
  static bool checkRange(int i, int j, int nRow, int nCol) {
    return i >= 0 && j >= 0 && i < nRow && j < nCol;
  }

  static List<List<CellInfo>> calculateValues(List<List<CellInfo>> origin) {
    List<List<CellInfo>> newOrigin = [];

    for (var (i, row) in origin.indexed) {
      newOrigin.add([]);
      for (var (j, cellInfo) in row.indexed) {
        newOrigin[i].add(cellInfo.copyWith(value: calculateAdjValue(i, j, origin)));
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
      counter += checkRange(row + i, col + j, origin.length, origin[0].length) &&
              origin[row + i][col + j].color == currentColor
          ? 1
          : 0;
    }

    return counter;
  }
}
