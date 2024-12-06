part of 'game_bloc.dart';

@immutable
sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

final class GameInitial extends GameEvent {}

final class _GameInitialDebugMode extends GameEvent {}

final class LoadGame extends GameEvent {
  final int gameNumber;

  const LoadGame(this.gameNumber);

  @override
  List<Object?> get props => [gameNumber];
}
