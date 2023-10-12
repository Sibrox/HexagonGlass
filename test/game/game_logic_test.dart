import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/game/game.dart';

void main() {
  test('Test checkRange', () {
    Game game = Game.buildFromString("1 2 1 1\n2 2 2 -\n1 2 1 -");

    assert(Logic.checkRange(-1, 0, game.origin.length, game.origin[0].length) ==
        false);
    assert(Logic.checkRange(0, -1, game.origin.length, game.origin[0].length) ==
        false);
    assert(Logic.checkRange(3, 0, game.origin.length, game.origin[0].length) ==
        false);
    assert(Logic.checkRange(0, 4, game.origin.length, game.origin[0].length) ==
        false);

    assert(Logic.checkRange(0, 0, game.origin.length, game.origin[0].length));
    assert(Logic.checkRange(2, 0, game.origin.length, game.origin[0].length));
    assert(Logic.checkRange(0, 3, game.origin.length, game.origin[0].length));
    assert(Logic.checkRange(2, 3, game.origin.length, game.origin[0].length));
  });

  test('Test calculateAdjValue', () {
    Game game = Game.buildFromString("1 2 1 1\n2 2 2 -\n1 2 1 -");

    assert(Logic.calculateAdjValue(0, 0, game.origin) == 0);
    assert(Logic.calculateAdjValue(0, 1, game.origin) == 2);
    assert(Logic.calculateAdjValue(0, 2, game.origin) == 1);
    assert(Logic.calculateAdjValue(1, 1, game.origin) == 4);
    assert(Logic.calculateAdjValue(1, 2, game.origin) == 1);
  });
}
