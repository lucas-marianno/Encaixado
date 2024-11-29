import 'package:encaixado/domain/usecases/calculate_days_from_epoch.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class LoadTodaysGameUseCase {
  final CalculateDaysFromAppEpochUsecase calculateDays;
  final LetterBoxedEngine engine;

  LoadTodaysGameUseCase({required this.engine, required this.calculateDays});

  Game call() {
    final games = engine.getPreGeneratedGames();
    final gameNumber = calculateDays() % games.length;

    return games[gameNumber];
  }
}
