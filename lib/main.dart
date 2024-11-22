import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

import 'presentation/bloc/game_bloc.dart';
import 'presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final gameEngine = LetterBoxedEngine(GameLanguage.pt);
  await gameEngine.init();
  runApp(MyApp(gameEngine));
}

class MyApp extends StatelessWidget {
  final LetterBoxedEngine gameEngine;
  const MyApp(this.gameEngine, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc(gameEngine),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
