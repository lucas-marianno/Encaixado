part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final ThemeMode themeMode;

  const SettingsLoaded(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}
