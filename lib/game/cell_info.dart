import 'package:equatable/equatable.dart';

import 'cell_colors.dart';

const nextColor = {
  CellColors.primary: CellColors.secondary,
  CellColors.secondary: CellColors.grey,
  CellColors.grey: CellColors.primary
};

class CellInfo extends Equatable {
  final CellColors color;
  final bool isEnable;
  final bool isVisible;
  final int value;

  const CellInfo(
      {required this.color,
      this.isEnable = true,
      this.isVisible = true,
      this.value = 0});

  factory CellInfo.buildFromOrigin(CellInfo originInfo) {
    return CellInfo(
        color: CellColors.grey,
        isEnable: originInfo.isEnable,
        isVisible: originInfo.isVisible,
        value: originInfo.value);
  }

  factory CellInfo.toggle(CellInfo current) {
    return current.copyWith(color: nextColor[current.color] as CellColors);
  }

  factory CellInfo.fromString(String stringCellInfo) {
    return CellInfo(
        color: stringToCellColors[stringCellInfo] as CellColors,
        isVisible: stringCellInfo != '-' ? true : false);
  }

  CellInfo copyWith({color, isEnable, isVisible, value}) {
    return CellInfo(
        color: color ?? this.color,
        isEnable: isEnable ?? this.isEnable,
        isVisible: isVisible ?? this.isVisible,
        value: value ?? this.value);
  }

  @override
  String toString() {
    return !isVisible ? "-" : cellColorsToString[color] as String;
  }

  @override
  List<Object?> get props => [color, isVisible, isEnable, value];
}
