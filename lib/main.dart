import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_cubit/cubits/cubits.dart';
import 'package:weather_cubit/pages/pages.dart';
import 'package:weather_cubit/repositories/repositories.dart';
import 'package:weather_cubit/services/services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(httpClient: http.Client()),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsCubit>(
            create: (context) => TempSettingsCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(
              weatherCubit: context.read<WeatherCubit>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Weather App',
              debugShowCheckedModeBanner: false,
              theme:state.appTheme == AppTheme.light
                  ? ThemeData.light(useMaterial3: true)
                  : ThemeData.dark(useMaterial3: true),
              home: const HomePage(),
            );
          },
        ),
      ),
    );
  }
}
