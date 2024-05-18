import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_cubit/models/models.dart';
import 'package:weather_cubit/repositories/repositories.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({
    required this.weatherRepository,
  }) : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final Weather weather = await weatherRepository.fetchWeather(city);

      emit(state.copyWith(
        status: WeatherStatus.leaded,
        weather: weather,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: e,
      ));
    }
  }
}
