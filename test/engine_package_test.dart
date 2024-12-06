import 'package:flutter_test/flutter_test.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final engine = LetterBoxedEngine(GameLanguage.pt);

  setUpAll(() async {
    await engine.init();
  });
  test('Engine should generate a game', () async {
    final game = await engine.generateGame();

    expect(game.solution.isNotEmpty, true, reason: game.toString());
  });
  test('Engine should load a games', () async {
    final games = engine.getPreGeneratedGames();

    expect(games.isNotEmpty, true);
    expect(games[0].solution.isNotEmpty, true, reason: games[0].toString());
  });
}
