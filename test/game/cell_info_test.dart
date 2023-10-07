import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/game/cell_colors.dart';
import 'package:hexagon_glass/game/cell_info.dart';

void main() {
  test('Test CellInfo build from originInfo', () {
    CellInfo originCell = CellInfo(color: CellColors.primary);
    CellInfo gameCell = CellInfo.buildFromOrigin(originCell);

    assert(gameCell.color == CellColors.grey);
  });

  test('Test CellInfo serialize', () {
    CellInfo primary = CellInfo(color: CellColors.primary);
    assert(primary.toString() == '1');

    CellInfo secondary = CellInfo(color: CellColors.secondary);
    assert(secondary.toString() == '2');

    CellInfo grey = CellInfo(color: CellColors.grey);
    assert(grey.toString() == '0');

    CellInfo notVisible = CellInfo(color: CellColors.primary, isVisible: false);
    assert(notVisible.toString() == '-');
  });

  test('Test CellInfo deserialize', () {
    assert(CellInfo(color: CellColors.primary) == CellInfo.fromString('1'));
    assert(CellInfo(color: CellColors.secondary) == CellInfo.fromString('2'));
    assert(CellInfo(color: CellColors.grey) == CellInfo.fromString('0'));
    assert(CellInfo(color: CellColors.grey, isVisible: false) ==
        CellInfo.fromString('-'));
  });

  test('Test toggle CellInfo', () {
    CellInfo info = CellInfo(color: CellColors.primary);

    info.toggle();
    assert(info.color == CellColors.secondary);
    info.toggle();
    assert(info.color == CellColors.grey);
    info.toggle();
    assert(info.color == CellColors.primary);
  });
}
