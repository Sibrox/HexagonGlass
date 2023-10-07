import 'package:hexagon_glass/game/bloc/game_bloc.dart';
import 'package:hexagon_glass/game/cell_colors.dart';
import 'package:hexagon_glass/game/cell_info.dart';
import 'package:hexagon_glass/game/game.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('GameBloc', () {
    blocTest('Load Game from string',
        build: () =>
            GameBloc(Game(origin: [[]], status: [[]], nCol: 0, nRow: 0)),
        act: (bloc) =>
            bloc.add(const GameLoadEvent("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0")),
        expect: () {
          Game assertGame =
              Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0");
          return [assertGame];
        });

    blocTest('Click on game', build: () {
      return GameBloc(
          Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0"));
    }, act: (bloc) {
      bloc.add(const GameClickEvent(0, 1));
    }, expect: () {
      Game assertGame =
          Game.buildFromString("- 2 - 0\n2 1 2 -\n2 - 2 -\n- - - 0");
      assertGame.status[0][1] = CellInfo(color: CellColors.primary);
      return [assertGame];
    });

    blocTest('Reload game',
        build: () {
          Game game =
              Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0");
          game.status[0][1].toggle();
          return GameBloc(game);
        },
        act: (bloc) => bloc.add(const GameReloadEvent()),
        expect: () {
          Game assertGame =
              Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0");
          return [assertGame];
        });
  });
}
