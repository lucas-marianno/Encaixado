import 'package:encaixado/presentation/bloc/game_bloc.dart';
import 'package:encaixado/presentation/pages/letter_boxed_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          title: const Text('Encaixado'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GameLoaded) {
              return LetterBoxedScreen(
                gameEngine: state.gameEngine,
                gameBox: state.gameBox,
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
