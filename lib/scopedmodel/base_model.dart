import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:weather/utils/uilibs.dart';
import 'package:http/http.dart' as http;

class BaseModel extends Model {
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

      if (response.statusCode == 200) {
        UiLibs.isError = false;
        // var list = responseData['weather'] as List;
        // List<Weather> listBanner = List();
        // for (int i = 0; i < 1; i++) {
        //   listBanner.add(Weather.fromJson(list[i]));
        // }
        // weatherHeader = WeatherHeader(
        //     base: responseData['base'].toString(),
        //     clouds: Clouds.fromJson(responseData['clouds']),
        //     cod: responseData['cod'].toString(),
        //     coord: Coord.fromJson(responseData['coord']),
        //     dt: responseData['dt'].toString(),
        //     id: responseData['id'].toString(),
        //     main: Main.fromJson(responseData['main']),
        //     name: responseData['name'].toString(),
        //     rain: Rain.fromJson(responseData['rain']),
        //     sys: Sys.fromJson(responseData['sys']),
        //     timezone: responseData['timezone'].toString(),
        //     weather: listBanner,
        //     wind: Wind.fromJson(responseData['wind']));
        // return weatherHeader;
        return responseData;
      } else {
        // weatherHeader = WeatherHeader(
        //   message: responseData['message'].toString(),
        // );
        return responseData;
        ;
      }
    } catch (error) {
      var message;
      print(error);
      UiLibs.isError = true;

      if (error.toString() ==
          "SocketException: Failed host lookup: 'api.openweathermap.org' (OS Error: No address associated with hostname, errno = 7)") {
        message = 'Please check your connection, try again';
      }

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
      print('error forecast');

      return message;
    }
  }

  Future<dynamic> fetchpostweatherCheck() async {
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
        // var list = responseData['weather'] as List;
        // List<Weather> listBanner = List();
        // for (int i = 0; i < 1; i++) {
        //   listBanner.add(Weather.fromJson(list[i]));
        // }
        // weatherHeader = WeatherHeader(
        //     base: responseData['base'].toString(),
        //     clouds: Clouds.fromJson(responseData['clouds']),
        //     cod: responseData['cod'].toString(),
        //     coord: Coord.fromJson(responseData['coord']),
        //     dt: responseData['dt'].toString(),
        //     id: responseData['id'].toString(),
        //     main: Main.fromJson(responseData['main']),
        //     name: responseData['name'].toString(),
        //     rain: Rain.fromJson(responseData['rain']),
        //     sys: Sys.fromJson(responseData['sys']),
        //     timezone: responseData['timezone'].toString(),
        //     weather: listBanner,
        //     wind: Wind.fromJson(responseData['wind']));
        // return weatherHeader;
        return responseData;
      } else {
        // weatherHeader = WeatherHeader(
        //   message: responseData['message'].toString(),
        // );
        return responseData;
      }
    } catch (error) {
      var message;
      print(error);
      UiLibs.isError = true;

      if (error.toString() ==
          "SocketException: Failed host lookup: 'api.openweathermap.org' (OS Error: No address associated with hostname, errno = 7)") {
        message = 'Please check your connection, try again';
      } else {
        message = error;
      }

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
      print('error forecast');

      return message;
    }
  }
}

final apiBase = BaseModel();
