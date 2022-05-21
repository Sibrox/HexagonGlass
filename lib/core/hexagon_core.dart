import "dart:io";
import 'dart:math';

enum HexagonColor {
  color_1,
  color_2,
  gray
}

class HexagonBlock {
  late int value;
  late bool isVisible;
  late HexagonColor color;

  HexagonBlock() {
    value = 0;
    color = HexagonColor.gray;
    isVisible = true;
  }

  HexagonBlock.init(HexagonColor startColor) {
    value = 0;
    color = startColor;
    isVisible = true;
  }

  HexagonBlock.build(int startValue, bool visibility) {
    value = startValue;
    color = HexagonColor.gray;
    isVisible = visibility;
  }

  void changeColor()
  {
    if(color == HexagonColor.gray){
      color = HexagonColor.color_1;
    }
    else if(color == HexagonColor.color_1) {
      color = HexagonColor.color_2;
    }
    else{
      color = HexagonColor.gray;
    }
  }

  @override
  String toString(){
    return color == HexagonColor.color_1 ? "1" : "0";
  }
}

class HexagonGame{
  late List<List<HexagonBlock>> gameGrid;
  late List<List<HexagonBlock>> statusGrid;

  HexagonGame.create(int width, int height) {
    initGrid(width, height);
    calculateGrid();
  }

  void initGrid(int width, int height) {
    gameGrid = <List<HexagonBlock>>[];
    statusGrid = <List<HexagonBlock>>[];
    for (int i = 0; i < height; i++) {
      gameGrid.add([]);
      statusGrid.add([]);
      for (int j = 0; j < width; j++) {
        var color = Random().nextInt(2) == 1 ?
          HexagonColor.color_1 : HexagonColor.color_2;

        var visibility = Random().nextInt(30);
        gameGrid[i].add(HexagonBlock.init(color));
        statusGrid[i].add(HexagonBlock());
      }
    }
  }

  bool checkRange(int i, int j)
  {
    return i >= 0 && j >= 0
        && i < gameGrid.length && j < gameGrid[0].length;
  }

  int calculateAdjValue(int i, int j) {

    int counter = 0;
    int offset = i%2 == 0? 0 : 1;

    HexagonColor currentColor = gameGrid[i][j].color;

    var top   = i - 1;
    var bot   = i + 1;
    var left  = j - 1;
    var right = j + 1;
    // left
    counter += checkRange(i, left)
        &&  gameGrid[i][left].color == currentColor? 1 : 0;
    // right
    counter += checkRange(i, right)
        &&  gameGrid[i][right].color == currentColor? 1 : 0;

    left  += offset;
    right = left + 1;
    // top left
    counter += checkRange(top, left)
        &&  gameGrid[top][left].color == currentColor? 1 : 0;
    // top right
    counter += checkRange(top, right)
        &&  gameGrid[top][right].color == currentColor? 1 : 0;

    // bot left
    counter += checkRange(bot, left)
        &&  gameGrid[bot][left].color == currentColor? 1 : 0;
    // bot right
    counter += checkRange(bot, right)
        &&  gameGrid[bot][right].color == currentColor? 1 : 0;

    return counter;
  }

  void changeColor(int i, int j){
    statusGrid[i][j].changeColor();
  }

  void calculateGrid() {
    for(int i = 0; i < gameGrid.length; i++) {
      for (int j = 0; j < gameGrid[i].length; j++) {
        gameGrid[i][j].value = calculateAdjValue(i,j);
        statusGrid[i][j].value = gameGrid[i][j].value;
      }
    }
  }

  void printGrid() {
    //Colors
    for(int i = 0; i < gameGrid.length; i++) {
      if(i%2 != 0) stdout.write(' ');
      for(int j = 0; j < gameGrid[i].length; j++) {
        stdout.write(gameGrid[i][j].toString() + ' ');
      }
      stdout.write('\n');
    }
    //Values
    stdout.write('\n');
    for(int i = 0; i < gameGrid.length; i++) {
      if(i%2 != 0) stdout.write(' ');
      for(int j = 0; j < gameGrid[i].length; j++) {
        stdout.write(gameGrid[i][j].value.toString() + ' ');
      }
      stdout.write('\n');
    }
  }
}

void main(){
  HexagonGame grid = HexagonGame.create(10, 11);
  grid.printGrid();
}
