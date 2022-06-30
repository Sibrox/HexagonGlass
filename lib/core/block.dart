enum BlockColor { color_1, color_2, noColor }

class Block {

  late int value;
  late bool isVisible;
  late BlockColor color;

  Block() {
    value = 0;
    color = BlockColor.noColor;
    isVisible = true;
  }

  Block.build(this.value, this.isVisible, this.color);

  Block.random(int rand) {
    color = rand != 1
        ? rand == 2
        ? BlockColor.color_2
        : BlockColor.noColor
        : BlockColor.color_1;
    isVisible = color == BlockColor.noColor ? false : true;
    value = 0;
  }

  void changeColor() {
    if (color == BlockColor.noColor) {
      color = BlockColor.color_1;
    } else if (color == BlockColor.color_1) {
      color = BlockColor.color_2;
    } else {
      color = BlockColor.noColor;
    }
  }

  @override
  String toString() {
    return
      isVisible?
      color != BlockColor.color_1 ?
      color != BlockColor.color_2 ?
      "0" : "2" : "1" : "-";
  }

}
