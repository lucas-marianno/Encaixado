import 'package:bloc/bloc.dart';
import 'package:encaixado/domain/usecases/calculate_days_from_epoch.dart';
import 'package:encaixado/domain/usecases/load_game.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final LoadGameUseCase loadGame;
  final CalculateDaysFromAppEpochUsecase calculateDaysFromAppEpoch;
  final GameLanguage language;

  late final LetterBoxedEngine _gameEngine;

  GameBloc({
    required this.language,
    required this.loadGame,
    required this.calculateDaysFromAppEpoch,
  }) : super(GameLoading()) {
    on<GameInitial>(_onGameInitial);
    on<GameDebugMode>(_onGameDebugMode);

    add(kDebugMode ? GameDebugMode() : GameInitial());
  }

  _onGameInitial(_, Emitter<GameState> emit) async {
    emit(GameLoading());

    _gameEngine = LetterBoxedEngine(language);
    await _gameEngine.init();

    final game = loadGame(_gameEngine, calculateDaysFromAppEpoch());
    emit(GameLoaded(gameEngine: _gameEngine, game: game));
  }

  _onGameDebugMode(_, Emitter<GameState> emit) async {
    assert(kDebugMode);
    emit(GameLoading());

    _gameEngine = LetterBoxedEngine(GameLanguage.pt);
    await _gameEngine.init();

    final debugGame = Game(
      box: Box(fromString: 'aoe drm slt icn'),
      language: _gameEngine.language,
      nOfSolutions: 288568,
    );
    // transcendentalismo
    // candidataremos, sensorial
    // mercantilismo, ornamentando

    emit(GameLoaded(gameEngine: _gameEngine, game: debugGame));
  }
}
