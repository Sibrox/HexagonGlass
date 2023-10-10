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
        const CellInfo(color: CellColors.grey, isVisible: false));
    assert(game.origin[0][1] ==
        const CellInfo(color: CellColors.secondary, isVisible: true));
    assert(game.origin[1][1] ==
        const CellInfo(color: CellColors.primary, isVisible: true));
    assert(game.origin[3][3] ==
        const CellInfo(color: CellColors.grey, isVisible: true));
  });

  test('Test build from origin', () {
    String gameString = "- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0";
    Game game = Game.buildFromString(gameString);

    Game fromOrigin = Game.buildFromOrigin(game.origin);
    assert(fromOrigin.status[0][1] == const CellInfo(color: CellColors.grey));
  });

  test('Test generate from click', () {
    String gameString = "- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0";
    Game game = Game.buildFromString(gameString);

    Game assertGame = Game.generateFromClick(game, 0, 1);
    assert(
        assertGame.status[0][1] == const CellInfo(color: CellColors.primary));

    assertGame = Game.generateFromClick(assertGame, 0, 1);
    assert(
        assertGame.status[0][1] == const CellInfo(color: CellColors.secondary));

    assertGame = Game.generateFromClick(assertGame, 0, 1);
    assert(assertGame.status[0][1] == const CellInfo(color: CellColors.grey));

    assertGame = Game.generateFromClick(assertGame, 0, 1);
    assert(
        assertGame.status[0][1] == const CellInfo(color: CellColors.primary));
  });
}
