import 'package:flutter/foundation.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class LoadGameEngineUseCase {
  final GameLanguage language;

  LoadGameEngineUseCase(this.language);

  Future<LetterBoxedEngine> call({bool debugEngine = false}) async {
    final engine = LetterBoxedEngine(debugEngine ? GameLanguage.pt : language);

    await compute((_) async => await engine.init(), null);

    return engine;
  }
}
