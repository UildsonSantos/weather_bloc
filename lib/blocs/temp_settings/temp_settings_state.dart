part of 'temp_settings_bloc.dart';

enum TempUnit {
  celsius,
  fahrenheit,
}

final class TempSettingsState extends Equatable {
  final TempUnit tempUnit;

  const TempSettingsState({
    this.tempUnit = TempUnit.celsius,
  });

  factory TempSettingsState.initial() {
    return const TempSettingsState();
  }

  @override
  List<Object> get props => [tempUnit];

  @override
  String toString() => 'TempSettingsState(tempUnit: $tempUnit)';

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
