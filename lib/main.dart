import 'package:encaixado/domain/usecases/calculate_days_from_epoch.dart';
import 'package:encaixado/domain/usecases/load_game.dart';
import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

import 'presentation/bloc/game_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc(
        // TODO: Consider using an injection container
        language: GameLanguage.pt,
        loadGame: LoadGameUseCase(),
        calculateDaysFromAppEpoch: CalculateDaysFromAppEpochUsecase(),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
