import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/game/cell_colors.dart';
import 'package:hexagon_glass/game/cell_info.dart';

void main() {
  test('Test CellInfo build from originInfo', () {
    CellInfo originCell = const CellInfo(color: CellColors.primary);
    CellInfo gameCell = CellInfo.buildFromOrigin(originCell);

    assert(gameCell.color == CellColors.grey);
  });

  test('Test CellInfo serialize', () {
    CellInfo primary = const CellInfo(color: CellColors.primary);
    assert(primary.toString() == '1');

    CellInfo secondary = const CellInfo(color: CellColors.secondary);
    assert(secondary.toString() == '2');

    CellInfo grey = const CellInfo(color: CellColors.grey);
    assert(grey.toString() == '0');

    CellInfo notVisible =
        const CellInfo(color: CellColors.primary, isVisible: false);
    assert(notVisible.toString() == '-');
  });

  test('Test CellInfo deserialize', () {
    assert(
        const CellInfo(color: CellColors.primary) == CellInfo.fromString('1'));
    assert(const CellInfo(color: CellColors.secondary) ==
        CellInfo.fromString('2'));
    assert(const CellInfo(color: CellColors.grey) == CellInfo.fromString('0'));
    assert(const CellInfo(color: CellColors.grey, isVisible: false) ==
        CellInfo.fromString('-'));
  });

  test('Test toggle CellInfo', () {
    CellInfo info = const CellInfo(color: CellColors.primary);

    info = info.toggle();
    assert(info.color == CellColors.secondary);
    info = info.toggle();
    assert(info.color == CellColors.grey);
    info = info.toggle();
    assert(info.color == CellColors.primary);
  });

  test('Random CellInfo', () {
    CellInfo primary = CellInfo.random(1);
    assert(primary == const CellInfo(color: CellColors.primary));

    CellInfo secondary = CellInfo.random(2);
    assert(secondary == const CellInfo(color: CellColors.secondary));

    CellInfo invisible = CellInfo.random(0);
    assert(invisible == const CellInfo(color: CellColors.grey, isVisible: false, isEnable: false));
  });
}
