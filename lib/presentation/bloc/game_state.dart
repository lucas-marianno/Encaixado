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
  final Box gameBox;

  const GameLoaded({required this.gameEngine, required this.gameBox});

  @override
  List<Object?> get props => [gameEngine, gameBox];
}
