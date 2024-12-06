import 'package:encaixado/presentation/bloc/settings_bloc/settings_bloc.dart';
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
          const DarkModeToggle(),
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

class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    final settings = context.read<SettingsBloc>();
    return ListTile(
      leading: Icon(darkMode ? Icons.dark_mode : Icons.light_mode),
      title: const Text('Modo escuro'),
      trailing: Switch(
        value: darkMode,
        onChanged: (v) => settings.add(DarkThemeMode(v)),
      ),
    );
  }
}
