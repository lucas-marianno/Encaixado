import 'package:bloc/bloc.dart';
import 'package:encaixado/domain/usecases/load_todays_game.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final LoadTodaysGameUseCase loadTodaysGame;
  GameBloc(this.loadTodaysGame) : super(GameLoading()) {
    on<GameInitial>(_onGameInitial);
    on<GameDebugMode>(_onGameDebugMode);

    add(GameInitial());
  }

  _onGameInitial(_, Emitter<GameState> emit) async {
    emit(GameLoading());

    if (kDebugMode) {
      add(GameDebugMode());
      return;
    }

    final game = loadTodaysGame();
    emit(GameLoaded(gameEngine: loadTodaysGame.engine, game: game));
  }

  _onGameDebugMode(_, Emitter<GameState> emit) async {
    emit(GameLoading());

    late final LetterBoxedEngine engine;
    if (loadTodaysGame.engine.language != GameLanguage.pt) {
      engine = LetterBoxedEngine(GameLanguage.pt);
      await engine.init();
    } else {
      engine = loadTodaysGame.engine;
    }

    final debugGame = Game(
      box: Box(fromString: 'aoe drm slt icn'),
      language: engine.language,
      nOfSolutions: 288568,
    );
    // transcendentalismo
    // candidataremos, sensorial
    // mercantilismo, ornamentando

    emit(GameLoaded(gameEngine: engine, game: debugGame));
  }
}
