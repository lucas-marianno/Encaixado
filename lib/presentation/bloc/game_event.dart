part of 'game_bloc.dart';

@immutable
sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

final class GameInitial extends GameEvent {}
