import 'package:encaixado/core/theme.dart';
import 'package:encaixado/domain/usecases/calculate_days_from_epoch.dart';
import 'package:encaixado/domain/usecases/load_game.dart';
import 'package:encaixado/domain/usecases/load_game_engine.dart';
import 'package:encaixado/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

import 'presentation/bloc/game_bloc/game_bloc.dart';
import 'presentation/bloc/settings_bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GameBloc(
            // TODO: Consider using an injection container
            loadEngine: LoadGameEngineUseCase(GameLanguage.pt),
            loadGame: LoadGameUseCase(),
            calculateDaysFromAppEpoch: CalculateDaysFromAppEpochUsecase(),
          ),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(ThemeMode.system),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoaded) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            routes: Routes.routes,
            initialRoute: Routes.initialRoute,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
