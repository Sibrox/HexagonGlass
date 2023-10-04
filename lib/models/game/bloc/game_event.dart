part of 'game_bloc.dart';

sealed class GameEvent {
  const GameEvent();
}

final class GameReloadEvent extends GameEvent {
  const GameReloadEvent();
}

final class GameClickEvent extends GameEvent {
  final Point clicked;
  const GameClickEvent(this.clicked);
}

final class GameEndEvent extends GameEvent {
  const GameEndEvent();
}
