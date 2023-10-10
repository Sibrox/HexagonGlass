part of 'game.dart';

extension Logic on Game {
  bool checkRange(int i, int j) {
    return i >= 0 && j >= 0 && i < nRow && j < nCol;
  }

  void calculateValues() {
    for (var (i, row) in origin.indexed) {
      for (var (j, cellInfo) in row.indexed) {
        origin[i][j] = cellInfo.copyWith(value: calculateAdjValue(i, j));
      }
    }
  }

  int calculateAdjValue(int row, int col) {
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
      counter += checkRange(row + i, col + j) &&
              origin[row + i][col + j].color == currentColor
          ? 1
          : 0;
    }

    return counter;
  }
}
