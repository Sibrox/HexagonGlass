import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/core/block.dart';
import 'package:hexagon_glass/core/game_logic.dart';

void main() {
  test('Check game', () {
    GameLogic game = GameLogic(GridType.hexagon);

    expect(game.checkGame(), false);

    for (int i = 0; i < game.nRows(); i++) {
      for (int j = 0; j < game.nColumns(); j++) {
        game.status.matrix[i][j].color = game.origin.matrix[i][j].color;
      }
    }

    expect(game.checkGame(), true);

    for (int i = 0; i < game.nRows(); i++) {
      for (int j = 0; j < game.nColumns(); j++) {
        game.status.matrix[i][j].color =
            game.status.matrix[i][j].color == BlockColor.color_1
                ? BlockColor.color_2
                : BlockColor.color_1;
      }
    }

    expect(game.checkGame(), true);
  });

  test('Check uncompleted game', () {
    GameLogic game = GameLogic(GridType.hexagon);
    for (int i = 0; i < game.nRows(); i++) {
      for (int j = 0; j < game.nColumns(); j++) {
        game.status.matrix[i][j].color = game.origin.matrix[i][j].color;
      }
    }

    for (int i = 0; i < game.nRows(); i++) {
      for (int j = 0; j < game.nColumns(); j++) {
        if (game.origin.matrix[i][j].isVisible) {
          game.status.matrix[i][j].color =
              game.status.matrix[i][j].color == BlockColor.color_1
                  ? BlockColor.color_2
                  : BlockColor.color_1;
          break;
        }
      }
    }
    expect(game.checkGame(), false);
  });
}
