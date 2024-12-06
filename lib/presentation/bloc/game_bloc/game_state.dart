part of 'game_bloc.dart';

@immutable
sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

final class GameLoading extends GameState {}

final class GameLoaded extends GameState {
  final LetterBoxedEngine gameEngine;
  final Game game;

  const GameLoaded({required this.gameEngine, required this.game});

  @override
  List<Object?> get props => [gameEngine, game];
}
