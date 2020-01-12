import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather.dart';
import 'package:weather/utils/uilibs.dart';

class WeatherEvent {}

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {}

class WeatherLoaded extends WeatherState {
  WeatherHeader weatherHeader;
  // bool hasReached;

  WeatherLoaded({
    this.weatherHeader,
  }); //this.hasReached});

  WeatherLoaded copyWith({
    WeatherHeader weatherHeader,
  }) {
    //bool hasReached}) {
    return WeatherLoaded(
        weatherHeader: weatherHeader ??
            this.weatherHeader); // hasReached: hasReached ?? this.hasReached);
  }
}

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  WeatherHeader weatherHeader;

  @override
  WeatherState get initialState => super.initialState ?? WeatherLoading();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    WeatherHeader weatherHeader;

    if (state is WeatherLoading) {
      print("Masuk Loading");
      yield WeatherLoading();
      weatherHeader = await GetApi().fetchpostweather();
      print("Selesai Loading");

      yield WeatherLoaded(weatherHeader: weatherHeader);
    } else {
      WeatherLoaded weatherLoaded = state as WeatherLoaded;

      if (UiLibs.isRefresh) {
        yield WeatherLoading();
      }

      weatherHeader = await GetApi().fetchpostweather();

      UiLibs.isRefresh = false;
      print('error');
      print(UiLibs.isError);
      yield weatherHeader == null
          ? weatherLoaded.copyWith()
          : WeatherLoaded(weatherHeader: weatherHeader);
    }
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) {
    try {
      final weatherHeader = WeatherHeader.fromJson(json);
      return WeatherLoaded(weatherHeader: weatherHeader); //hasReached: false);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    try {
      if (state is WeatherLoaded) {
        return state.weatherHeader.toJson();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class GetApi extends WeatherState {
  WeatherHeader weatherHeader;

  Future<dynamic> fetchpostweather() async {
    print(UiLibs.nama);
    try {
      final response = await http.post(
        "http://api.openweathermap.org/data/2.5/weather?q=${UiLibs.kota}&APPID=7c91de0487b5128dd0eb50d2aedb3230&units=metric",
        headers: {
          "Accept": "application/json; charset=UTF-8",
        },
      );

      var responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        UiLibs.isError = false;
        var list = responseData['weather'] as List;
        List<Weather> listBanner = List();
        for (int i = 0; i < 1; i++) {
          listBanner.add(Weather.fromJson(list[i]));
        }
        weatherHeader = WeatherHeader(
            base: responseData['base'].toString(),
            clouds: Clouds.fromJson(responseData['clouds']),
            cod: responseData['cod'].toString(),
            coord: Coord.fromJson(responseData['coord']),
            dt: responseData['dt'].toString(),
            id: responseData['id'].toString(),
            main: Main.fromJson(responseData['main']),
            name: responseData['name'].toString(),
            // rain: Rain.fromJson(responseData['rain']),
            sys: Sys.fromJson(responseData['sys']),
            timezone: responseData['timezone'].toString(),
            weather: listBanner,
            wind: Wind.fromJson(responseData['wind']));
        return weatherHeader;
      } else {
        weatherHeader = WeatherHeader(
          message: responseData['message'].toString(),
        );
        return weatherHeader;
      }
    } catch (error) {
      print(error);
      UiLibs.isError = true;

      // if (error.toString() ==
      //     "SocketException: Failed host lookup: 'masjapp.id' (OS Error: No address associated with hostname, errno = 7)") {
      //   weatherHeader.message = 'Please check your connection, try again';
      // }

      // BuildContext context;
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text(
      //           'Error',
      //         ),
      //         content: Text('Please try again...'),
      //         actions: <Widget>[
      //           FlatButton(
      //             child: Text('Okay'),
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //           )
      //         ],
      //       );
      //     });
      print('error');

      return null;
    }
  }
}
