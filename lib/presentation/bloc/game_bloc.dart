import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:meta/meta.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late final LetterBoxedEngine _gameEngine;
  late final Game _game;

  final GameLanguage language;

  GameBloc(this.language) : super(GameLoading()) {
    on<GameInitial>(_onGameInitial);

    add(GameInitial());
  }

  _onGameInitial(GameEvent event, Emitter<GameState> emit) async {
    emit(GameLoading());

    _gameEngine = LetterBoxedEngine(language);
    await _gameEngine.init();

    _game = await _gameEngine.loadRandomGame();

    emit(GameLoaded(gameEngine: _gameEngine, game: _game));
  }
}
