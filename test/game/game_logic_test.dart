import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/game/game.dart';

void main() {
  test('Test checkRange', () {
    Game game = Game.buildFromString("1 2 1 1\n2 2 2 -\n1 2 1 -");

    assert(game.checkRange(-1, 0) == false);
    assert(game.checkRange(0, -1) == false);
    assert(game.checkRange(3, 0) == false);
    assert(game.checkRange(0, 4) == false);

    assert(game.checkRange(0, 0));
    assert(game.checkRange(2, 0));
    assert(game.checkRange(0, 3));
    assert(game.checkRange(2, 3));
  });

  test('Test calculateAdjValue', () {
    Game game = Game.buildFromString("1 2 1 1\n2 2 2 -\n1 2 1 -");

    assert(game.calculateAdjValue(0, 0) == 0);
    assert(game.calculateAdjValue(0, 1) == 2);
    assert(game.calculateAdjValue(0, 2) == 1);
    assert(game.calculateAdjValue(1, 1) == 4);
    assert(game.calculateAdjValue(1, 2) == 1);
  });
}
