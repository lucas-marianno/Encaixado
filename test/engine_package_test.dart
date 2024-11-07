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

    print(game.sampleSolutions);

    expect(game.sampleSolutions!.isNotEmpty, true,
        reason: 'engine should generate a game with sample solutions');
    expect(game.nOfSolutions > 0, true);
  });
  test('Engine should load a game', () async {
    final game = await engine.loadRandomGame();

    expect(game.nOfSolutions > 0, true);
  });
}
