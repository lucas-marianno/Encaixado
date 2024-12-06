part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

final class SettingsInitial extends SettingsEvent {}

final class DarkThemeMode extends SettingsEvent {
  final bool? enabled;

  const DarkThemeMode(this.enabled);

  @override
  List<Object?> get props => [enabled];
}
