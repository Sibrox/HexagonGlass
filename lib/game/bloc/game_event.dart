part of 'game_bloc.dart';

sealed class GameEvent {
  const GameEvent();
}

final class GameLoadEvent extends GameEvent {
  final String origin;
  const GameLoadEvent(this.origin);
}

final class GameReloadEvent extends GameEvent {
  const GameReloadEvent();
}

final class GameClickEvent extends GameEvent {
  final int i, j;
  const GameClickEvent(this.i, this.j);
}