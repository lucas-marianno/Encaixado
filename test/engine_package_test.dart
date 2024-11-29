import 'package:flutter_test/flutter_test.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final engine = LetterBoxedEngine(GameLanguage.pt);

  setUpAll(() async {
    await engine.init();
  });
  test('Engine should generate a game', () async {
    final game = await engine.generateGame(ensureSolvable: true);

    expect(game.nOfSolutions > 0, true, reason: game.toString());
  });
  test('Engine should load a game', () async {
    final game = engine.getPreGeneratedGames();

    expect(game[0].nOfSolutions > 0, true, reason: game.toString());
  });
}
