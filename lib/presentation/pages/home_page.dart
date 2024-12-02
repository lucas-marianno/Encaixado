import 'package:encaixado/presentation/bloc/game_bloc.dart';
import 'package:encaixado/presentation/pages/letter_boxed/letter_boxed_page.dart';
import 'package:flutter/material.dart';

import '../widgets/left_drawer.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const LeftDrawer(),
        appBar: AppBar(title: const Text('Encaixado'), centerTitle: true),
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GameLoaded) {
              return LetterBoxedScreen(
                gameEngine: state.gameEngine,
                game: state.game,
              );
            } else {
              throw FlutterError("W H A T   T H E   F U C K");
            }
          },
        ),
      ),
    );
  }
}
