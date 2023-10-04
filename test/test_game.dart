import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/models/game/cell_colors.dart';
import 'package:hexagon_glass/models/game/cell_info.dart';
import 'package:hexagon_glass/models/game/game.dart';

void main() {
  test('Test build game from string', () {
    String gameString = "- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0";
    Game game = Game.buildFromString(gameString);

    assert(game.nRow == 4);
    assert(game.nCol == 4);

    assert(game.origin[0][0]
        .equals(CellInfo(color: CellColors.grey, isVisible: false)));
    assert(game.origin[0][1]
        .equals(CellInfo(color: CellColors.secondary, isVisible: true)));
    assert(game.origin[1][1]
        .equals(CellInfo(color: CellColors.primary, isVisible: true)));
    assert(game.origin[3][3]
        .equals(CellInfo(color: CellColors.grey, isVisible: true)));
  });
}
