import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:meta/meta.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final LetterBoxedEngine gameEngine;
  late final Game _game;

  GameBloc(this.gameEngine) : super(GameLoading()) {
    on<GameInitial>(_onGameInitial);

    add(GameInitial());
  }

  _onGameInitial(_, Emitter<GameState> emit) async {
    emit(GameLoading());

    // _game = await gameEngine.loadRandomGame();
    _game = Game(
      box: Box(fromString: "cnr ota iep mus"),
      language: GameLanguage.pt,
      nOfSolutions: 58732,
    );

    emit(GameLoaded(gameEngine: gameEngine, game: _game));
  }
}
