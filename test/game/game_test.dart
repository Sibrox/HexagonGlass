import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/game/cell_colors.dart';
import 'package:hexagon_glass/game/cell_info.dart';
import 'package:hexagon_glass/game/game.dart';

void main() {
  test('Test build game from string', () {
    String gameString = "1 2 1 2\n2 1 1 -\n1 2 2 2";
    Game game = Game.buildFromString(gameString);

    assert(game.nRow == 3);
    assert(game.nCol == 4);

    assert(game.origin[0][0] ==
        const CellInfo(color: CellColors.primary, isVisible: true, value: 0));
    assert(game.origin[0][1] ==
        const CellInfo(color: CellColors.secondary, isVisible: true, value: 1));
    assert(game.origin[1][1] ==
        const CellInfo(color: CellColors.primary, isVisible: true, value: 2));
    assert(game.status[1][3] ==
        const CellInfo(color: CellColors.grey, isVisible: false, value: 0));
    assert(game.origin[2][3] ==
        const CellInfo(color: CellColors.secondary, isVisible: true, value: 1));
  });

  test('Test build from origin', () {
    String gameString = "1 2 1 2\n2 1 1 -\n1 2 2 2";
    Game game = Game.buildFromString(gameString);

    Game fromOrigin = Game.buildFromOrigin(game.origin);
    assert(fromOrigin.status[0][1] ==
        const CellInfo(color: CellColors.grey, value: 1));
  });

  test('Test generate from click', () {
    String gameString = "1 2 1 2\n2 1 1 -\n1 2 2 2";
    Game game = Game.buildFromString(gameString);

    Game assertGame = Game.generateFromClick(game, 0, 1);
    assert(assertGame.status[0][1] ==
        const CellInfo(color: CellColors.primary, value: 1));

    assertGame = Game.generateFromClick(assertGame, 0, 1);
    assert(assertGame.status[0][1] ==
        const CellInfo(color: CellColors.secondary, value: 1));

    assertGame = Game.generateFromClick(assertGame, 0, 1);
    assert(assertGame.status[0][1] ==
        const CellInfo(color: CellColors.grey, value: 1));

    assertGame = Game.generateFromClick(assertGame, 0, 1);
    assert(assertGame.status[0][1] ==
        const CellInfo(color: CellColors.primary, value: 1));
  });
}
