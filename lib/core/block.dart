enum BlockColor { color_1, color_2, noColor }

class Block {
  late int value;
  late bool isVisible;
  late bool isEnabled;
  late BlockColor color;

  Block() {
    value = 0;
    color = BlockColor.noColor;
    isVisible = true;
    isEnabled = true;
  }

  Block.build(this.value, this.isVisible, this.color, this.isEnabled);

  Block.random(int rand) {
    color = rand != 1
        ? rand == 2
            ? BlockColor.color_2
            : BlockColor.noColor
        : BlockColor.color_1;
    isVisible = color == BlockColor.noColor ? false : true;
    isEnabled = isVisible;
    value = 0;
  }

  void changeColor() {
    if (color == BlockColor.noColor && isVisible) {
      color = BlockColor.color_1;
    } else if (color == BlockColor.color_1 && isVisible) {
      color = BlockColor.color_2;
    } else {
      color = BlockColor.noColor;
    }
  }

  @override
  String toString() {
    return isVisible
        ? color != BlockColor.color_1
            ? color != BlockColor.color_2
                ? "0"
                : "2"
            : "1"
        : "-";
  }

  bool getVisible() {
    return isVisible;
  }
}
