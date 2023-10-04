import 'cell_colors.dart';

const nextColor = {
  CellColors.primary: CellColors.secondary,
  CellColors.secondary: CellColors.grey,
  CellColors.grey: CellColors.primary
};

class CellInfo {
  CellColors color;
  bool isEnable;
  bool isVisible;

  CellInfo({required this.color, this.isEnable = true, this.isVisible = true});

  factory CellInfo.buildFromOrigin(CellInfo originInfo) {
    return CellInfo(
        color: CellColors.grey,
        isEnable: originInfo.isEnable,
        isVisible: originInfo.isVisible);
  }

  void toggle() {
    color = nextColor[color] as CellColors;
  }

  factory CellInfo.fromString(String stringCellInfo) {
    return CellInfo(
        color: stringToCellColors[stringCellInfo] as CellColors,
        isVisible: stringCellInfo != '-' ? true : false);
  }

  @override
  String toString() {
    return !isVisible ? "-" : cellColorsToString[color] as String;
  }

  @override
  bool operator ==(Object other) {
    CellInfo otherCellInfo = other as CellInfo;
    return color == otherCellInfo.color &&
        isVisible == otherCellInfo.isVisible &&
        isEnable == otherCellInfo.isEnable;
  }

  @override
  int get hashCode =>
      (color.toString() + isVisible.toString() + isEnable.toString()).hashCode;
}
