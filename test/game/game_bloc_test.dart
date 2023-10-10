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
            GameBloc(const Game(origin: [[]], status: [[]], nCol: 0, nRow: 0)),
        act: (bloc) =>
            bloc.add(const GameLoadEvent("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0")),
        expect: () {
          Game assertGame =
              Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0");
          return [assertGame];
        });

    blocTest('Click on game', build: () {
      return GameBloc(
          Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 1"));
    }, act: (bloc) {
      bloc.add(const GameClickEvent(0, 1));
    }, expect: () {
      Game assertGame =
          Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 1");

      List<List<CellInfo>> newStatus = List.from(assertGame.status);
      newStatus[0][1] = newStatus[0][1].copyWith(color: CellColors.primary);
      return [
        Game(
            nCol: assertGame.nCol,
            nRow: assertGame.nRow,
            origin: assertGame.origin,
            status: newStatus)
      ];
    });

    blocTest('Double click on game', build: () {
      return GameBloc(
          Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 1"));
    }, act: (bloc) {
      bloc.add(const GameClickEvent(0, 1));
      bloc.add(const GameClickEvent(0, 1));
    }, expect: () {
      Game firstState =
          Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 1");
      firstState.status[0][1] = firstState.status[0][1].copyWith(color: CellColors.primary);

      Game secondState =
          Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 1");
      secondState.status[0][1] = secondState.status[0][1].copyWith(color: CellColors.secondary);

      return [firstState, secondState];
    });

    blocTest('Reload game',
        build: () {
          Game game =
              Game.buildFromString("- 2 - 2\n2 1 2 -\n2 - 2 -\n- - - 0");
          game.status[0][1] = CellInfo.toggle(game.status[0][1]);
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
