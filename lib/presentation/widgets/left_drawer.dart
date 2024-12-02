import 'package:encaixado/presentation/pages/previous_games/previous_games_page.dart';
import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 50),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Jogos anteriores'),
            onTap: () {
              Navigator.popAndPushNamed(context, PreviousGamesPage.routeName);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Modo escuro'),
            trailing: Switch(value: false, onChanged: (v) {}),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Sobre'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
