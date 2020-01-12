import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather/bloc/forecasting_bloc.dart';
import 'package:weather/bloc/nama_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/ui/home.dart';
import 'package:weather/ui/splashscreen.dart';

void main() async {
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ForecastingBloc>(
          builder: (context) => ForecastingBloc(),
        ),
        BlocProvider<TextBloc>(
          builder: (context) => TextBloc(),
        ),
        BlocProvider<WeatherBloc>(
          builder: (context) => WeatherBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Color(0xff3e206d),
            accentColor: Color(0xff436E4F),
            fontFamily: 'Google Sans'),
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}
