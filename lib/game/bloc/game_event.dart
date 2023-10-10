part of 'game_bloc.dart';

sealed class GameEvent {
  const GameEvent();
}

final class GameLoadEvent extends GameEvent {
  final String origin;
  const GameLoadEvent(this.origin);
}

final class GenerateRandomEvent extends GameEvent {
  final int nRow, nCol;
  const GenerateRandomEvent(this.nRow, this.nCol);
}

final class GameReloadEvent extends GameEvent {
  const GameReloadEvent();
}

final class GameClickEvent extends GameEvent {
  final int i, j;
  const GameClickEvent(this.i, this.j);
}
