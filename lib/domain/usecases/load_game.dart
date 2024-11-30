import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class LoadGameUseCase {
  LoadGameUseCase();

  Game call(LetterBoxedEngine engine, int gameNumber) {
    final games = engine.getPreGeneratedGames();
    final n = gameNumber % games.length;

    return games[n];
  }
}
