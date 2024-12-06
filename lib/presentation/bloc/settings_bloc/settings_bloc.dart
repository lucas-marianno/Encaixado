import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ThemeMode initialThemeMode;

  SettingsBloc(this.initialThemeMode) : super(SettingsLoading()) {
    on<SettingsInitial>(_onSettingsInitial);
    on<DarkThemeMode>(_onChangeThemeMode);

    add(SettingsInitial());
  }

  _onSettingsInitial(SettingsInitial event, Emitter<SettingsState> emit) {
    emit(SettingsLoaded(initialThemeMode));
  }

  _onChangeThemeMode(DarkThemeMode event, Emitter<SettingsState> emit) {
    if (event.enabled == null) {
      emit(const SettingsLoaded(ThemeMode.system));
    } else {
      final mode = event.enabled! ? ThemeMode.dark : ThemeMode.light;

      emit(SettingsLoaded(mode));
    }
  }
}
