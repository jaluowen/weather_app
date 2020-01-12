import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/forecast.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/utils/uilibs.dart';

class ForecastingEvent {}

abstract class ForecastingState {}

class ForecastingInitial extends ForecastingState {}

class ForecastingLoading extends ForecastingState {}

class ForecastingError extends ForecastingState {}

class ForecastingLoaded extends ForecastingState {
  ForecastHeader forecastingHeader;
  // bool hasReached;

  ForecastingLoaded({
    this.forecastingHeader,
  }); //this.hasReached});

  ForecastingLoaded copyWith({
    ForecastHeader forecastingHeader,
  }) {
    //bool hasReached}) {
    return ForecastingLoaded(
        forecastingHeader: forecastingHeader ??
            this.forecastingHeader); // hasReached: hasReached ?? this.hasReached);
  }
}

class ForecastingBloc extends HydratedBloc<ForecastingEvent, ForecastingState> {
  ForecastHeader forecastingHeader;

  @override
  ForecastingState get initialState =>
      super.initialState ?? ForecastingLoading();

  @override
  Stream<ForecastingState> mapEventToState(ForecastingEvent event) async* {
    ForecastHeader forecastingHeader;

    if (state is ForecastingLoading) {
      print("Masuk Loading");
      yield ForecastingLoading();
      forecastingHeader = await GetApi().fetchpostweather();
      print("Selesai Loading");

      yield ForecastingLoaded(forecastingHeader: forecastingHeader);
    } else {
      ForecastingLoaded forecastingLoaded = state as ForecastingLoaded;

      if (UiLibs.isRefresh) {
        yield ForecastingLoading();
      }

      forecastingHeader = await GetApi().fetchpostweather();

      UiLibs.isRefresh = false;
      print('error');
      print(UiLibs.isError);
      yield forecastingHeader == null
          ? forecastingLoaded.copyWith()
          : ForecastingLoaded(forecastingHeader: forecastingHeader);
    }
  }

  @override
  ForecastingState fromJson(Map<String, dynamic> json) {
    try {
      final forecastingHeader = ForecastHeader.fromJson(json);
      return ForecastingLoaded(
          forecastingHeader: forecastingHeader); //hasReached: false);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(ForecastingState state) {
    try {
      if (state is ForecastingLoaded) {
        return state.forecastingHeader.toJson();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class GetApi extends ForecastingState {
  ForecastHeader forecastingHeader;

  Future<dynamic> fetchpostweather() async {
    print(UiLibs.nama);
    try {
      final response = await http.post(
        "http://api.openweathermap.org/data/2.5/forecast?q=${UiLibs.kota}&APPID=7c91de0487b5128dd0eb50d2aedb3230&units=metric",
        headers: {
          "Accept": "application/json; charset=UTF-8",
        },
      );

      var responseData = json.decode(response.body);
      print(responseData);
      var newMap = groupBy(responseData['list'],
          (obj) => obj['dt_txt'].toString().substring(0, 10));

      print(newMap);
      if (response.statusCode == 200) {
        UiLibs.isError = false;

        var list = responseData['list'] as List;
        List<ForecastList> listBanner = List();
        for (int i = 0; i < list.length; i++) {
          listBanner.add(ForecastList.fromJson(list[i]));
        }
        forecastingHeader = ForecastHeader(
            city: City.fromJson(responseData['city']),
            cod: responseData['cod'].toString(),
            cnt: responseData['cnt'].toString(),
            list: listBanner,
            message: responseData['message'].toString());
        return forecastingHeader;
      } else {
        forecastingHeader = ForecastHeader(
          message: responseData['message'].toString(),
        );
        return forecastingHeader;
      }
    } catch (error) {
      print(error);
      UiLibs.isError = true;

      // if (error.toString() ==
      //     "SocketException: Failed host lookup: 'masjapp.id' (OS Error: No address associated with hostname, errno = 7)") {
      //   forecastingHeader.message = 'Please check your connection, try again';
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
