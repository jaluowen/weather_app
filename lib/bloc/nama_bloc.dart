import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather/utils/uilibs.dart';

enum TextEvent { toNama, toDua }

class TextBloc extends HydratedBloc<TextEvent, String> {
  @override
  String get initialState => super.initialState ?? ' ';

  @override
  Stream<String> mapEventToState(
    TextEvent event,
  ) async* {
    yield (event == TextEvent.toNama ? UiLibs.nama : 'Dua');
  }

  @override
  String fromJson(Map<String, dynamic> json) {
    try {
      return json['text'];
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, String> toJson(String state) {
    try {
      return {
        'text': state,
      };
    } catch (e) {
      return null;
    }
  }
}
