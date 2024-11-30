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

  int get daysFromEpoch => calculateDaysFromAppEpoch();
  late final LetterBoxedEngine _gameEngine;

  GameBloc({
    required this.language,
    required this.loadGame,
    required this.calculateDaysFromAppEpoch,
  }) : super(GameLoading()) {
    on<GameInitial>(_onGameInitial);
    on<_GameInitialDebugMode>(_onGameDebugMode);
    on<LoadGame>(_onLoadGame);

    add(kDebugMode ? _GameInitialDebugMode() : GameInitial());
  }

  _onGameInitial(_, Emitter<GameState> emit) async {
    emit(GameLoading());

    _gameEngine = LetterBoxedEngine(language);
    await _gameEngine.init();

    add(LoadGame(daysFromEpoch));
  }

  _onGameDebugMode(_, Emitter<GameState> emit) async {
    assert(kDebugMode);
    emit(GameLoading());

    _gameEngine = LetterBoxedEngine(GameLanguage.pt);
    await _gameEngine.init();

    // transcendentalismo
    // candidataremos, sensorial
    // mercantilismo, ornamentando
    add(const LoadGame(189));
  }

  _onLoadGame(LoadGame event, Emitter<GameState> emit) {
    emit(GameLoading());
    final game = loadGame(_gameEngine, event.gameNumber);

    emit(GameLoaded(gameEngine: _gameEngine, game: game));
  }
}
