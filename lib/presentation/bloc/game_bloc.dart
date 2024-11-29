import 'package:bloc/bloc.dart';
import 'package:encaixado/domain/usecases/load_todays_game.dart';
import 'package:equatable/equatable.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:meta/meta.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final LoadTodaysGameUseCase loadTodaysGame;
  GameBloc(this.loadTodaysGame) : super(GameLoading()) {
    on<GameInitial>(_onGameInitial);

    add(GameInitial());
  }

  _onGameInitial(GameEvent event, Emitter<GameState> emit) async {
    emit(GameLoading());

    final game = loadTodaysGame();

    emit(GameLoaded(gameEngine: loadTodaysGame.engine, game: game));
  }
}
