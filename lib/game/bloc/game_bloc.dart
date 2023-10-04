import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexagon_glass/game/game.dart';

part 'game_event.dart';

class GameBloc extends Bloc<GameEvent, Game> {
  GameBloc(Game game) : super(game) {
    on<GameLoadEvent>((event, emit) {
      emit(Game.buildFromString(event.origin));
    });

    on<GameClickEvent>((event, emit) {
      emit(state.generateFromClick(event.i, event.j));
    });

    on<GameReloadEvent>((event, emit) {
      emit(state.buildFromOrigin());
    });
  }
}
