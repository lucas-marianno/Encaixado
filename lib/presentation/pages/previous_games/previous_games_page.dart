import 'package:encaixado/core/constants.dart';
import 'package:encaixado/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:encaixado/presentation/pages/home_page.dart';
import 'package:encaixado/presentation/pages/previous_games/widgets/previous_game_button.dart';
import 'package:flutter/material.dart';

class PreviousGamesPage extends StatelessWidget {
  static const routeName = '/previousGamePage';
  const PreviousGamesPage({super.key});

  String _getPreviousGameButtonLabel(int gameNumber) {
    final epoch = DateTime.parse(kAppEpoch);
    final a = epoch.add(Duration(days: gameNumber));

    return '${a.day} ${_monthNamePt[a.month]}';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final gameBloc = context.read<GameBloc>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jogos anteriores'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.03,
            vertical: screenSize.width * 0.02,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: GridView.count(
              crossAxisCount: screenSize.width < 300 ? 2 : 4,
              children: [
                for (int i = 0; i <= gameBloc.daysFromEpoch; i++)
                  PreviousGameButton(
                    gameLabel: _getPreviousGameButtonLabel(i),
                    onTap: () {
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName(Home.routeName),
                      );
                      gameBloc.add(LoadGame(i));
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TODO: Replace this with i18n
final _monthNamePt = <int, String>{
  1: 'Jan',
  2: 'Fev',
  3: 'Mar',
  4: 'Abr',
  5: 'Mai',
  6: 'Jun',
  7: 'Jul',
  8: 'Ago',
  9: 'Set',
  10: 'Out',
  11: 'Nov',
  12: 'Dez',
};
