import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/game/cell_colors.dart';
import 'package:hexagon_glass/game/cell_info.dart';
import 'package:hexagon_glass/game/game.dart';

void main() {
  test('Test build game from string', () {
    String gameString = "- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0";
    Game game = Game.buildFromString(gameString);

    assert(game.nRow == 4);
    assert(game.nCol == 4);

    assert(game.origin[0][0] ==
        CellInfo(color: CellColors.grey, isVisible: false));
    assert(game.origin[0][1] ==
        CellInfo(color: CellColors.secondary, isVisible: true));
    assert(game.origin[1][1] ==
        CellInfo(color: CellColors.primary, isVisible: true));
    assert(
        game.origin[3][3] == CellInfo(color: CellColors.grey, isVisible: true));
  });

  test('Test build from origin', () {
    String gameString = "- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0";
    Game game = Game.buildFromString(gameString);

    Game fromOrigin = game.buildFromOrigin();
    assert(fromOrigin.status[0][1] == CellInfo(color: CellColors.grey));
  });

  test('Test generate from click', () {
    String gameString = "- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0";
    Game game = Game.buildFromString(gameString);

    Game assertGame = game.generateFromClick(0, 1);
    assert(assertGame.status[0][1] == CellInfo(color: CellColors.primary));

    assertGame = assertGame.generateFromClick(0, 1);
    assert(assertGame.status[0][1] == CellInfo(color: CellColors.secondary));

    assertGame = assertGame.generateFromClick(0, 1);
    assert(assertGame.status[0][1] == CellInfo(color: CellColors.grey));

    assertGame = assertGame.generateFromClick(0, 1);
    assert(assertGame.status[0][1] == CellInfo(color: CellColors.primary));
  });
}
