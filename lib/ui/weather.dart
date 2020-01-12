import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:weather/bloc/forecasting_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/scopedmodel/base_model.dart';
import 'package:weather/utils/uilibs.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  static MediaQueryData _mediaQueryData;
  var tanggal, tanggal2, tanggal3, tanggal4, tanggal5;
  var newMap;
  var date, date2, date3, date4, date5;
  String image;
  String sapaan;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(WeatherEvent());
    getInit();
  }

  getInit() async {
    setState(() {
      isLoading = true;
      if (DateTime.now().hour >= 00 && DateTime.now().hour < 12) {
        sapaan = 'Pagi';
      } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 15) {
        sapaan = 'Siang';
      } else if (DateTime.now().hour >= 15 && DateTime.now().hour <= 18) {
        sapaan = 'Sore';
      } else {
        sapaan = 'Malam';
      }
    });
    var getList = await apiBase.fetchpostweather();
    newMap = groupBy(
        getList['list'], (obj) => obj['dt_txt'].toString().substring(0, 10));
    var cloudy =
        'https://c.pxhere.com/photos/7d/20/mountain_range_clouds_above_fog_landscape_nature_view-719334.jpg!d';
    print(newMap);
    var string = DateFormat.yMEd()
        .add_jms()
        .format(DateTime.now().add(Duration(days: 1)))
        .toString();
    var string2 = DateFormat.yMEd()
        .add_jms()
        .format(DateTime.now().add(Duration(days: 2)))
        .toString();
    var string3 = DateFormat.yMEd()
        .add_jms()
        .format(DateTime.now().add(Duration(days: 3)))
        .toString();
    var string4 = DateFormat.yMEd()
        .add_jms()
        .format(DateTime.now().add(Duration(days: 4)))
        .toString();
    var string5 = DateFormat.yMEd()
        .add_jms()
        .format(DateTime.now().add(Duration(days: 5)))
        .toString();

    tanggal = string.split(',');
    tanggal2 = string2.split(',');
    tanggal3 = string3.split(',');
    tanggal4 = string4.split(',');
    tanggal5 = string5.split(',');

    date = DateTime.now().add(Duration(days: 1)).toString().substring(0, 10);
    date2 = DateTime.now().add(Duration(days: 2)).toString().substring(0, 10);
    date3 = DateTime.now().add(Duration(days: 3)).toString().substring(0, 10);
    date4 = DateTime.now().add(Duration(days: 4)).toString().substring(0, 10);
    date5 = DateTime.now().add(Duration(days: 5)).toString().substring(0, 10);

    // print('Ini Map Baru' + newMap['$date'][0]['dt'].toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherInitial) {
        // PostBloc()..add(EventEvent());
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is WeatherLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        WeatherLoaded weatherLoaded = state as WeatherLoaded;
        if (weatherLoaded.weatherHeader.weather[0].main == 'Clouds') {
          image = 'assets/img/Siang Berawan.jpg';
        } else if (weatherLoaded.weatherHeader.weather[0].main == 'Clear') {
          if (DateTime.now().hour >= 00 && DateTime.now().hour < 18) {
            image = 'assets/img/siang cerah.jpg';
          } else {
            image = 'assets/img/cerah malam.jpg';
          }
        } else {
          image = 'assets/img/hujan.jpg';
        }
        return Stack(children: <Widget>[
          Container(
            width: double.infinity,
            height: _mediaQueryData.size.height,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              color: Colors.blue[900],
              colorBlendMode: BlendMode.overlay,
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            weatherLoaded.weatherHeader.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.now()),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          WeatherBloc weatherBloc =
                              BlocProvider.of<WeatherBloc>(context);
                          weatherBloc.add(WeatherEvent());
                          getInit();
                        },
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Selamat $sapaan, ' + UiLibs.nama,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      weatherLoaded.weatherHeader.main.temp
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 60),
                                    ),
                                    Icon(
                                      WeatherIcons.celsius,
                                      color: Colors.white,
                                      size: 50,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  weatherLoaded.weatherHeader.weather[0].main,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      'http://openweathermap.org/img/wn/${weatherLoaded.weatherHeader.weather[0].icon}.png',
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.high,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.35),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      WeatherIcons.humidity,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      weatherLoaded
                                              .weatherHeader.main.humidity +
                                          ' %',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      WeatherIcons.barometer,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      weatherLoaded
                                              .weatherHeader.main.pressure +
                                          ' hpa',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    Text(
                                      'Pressure',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.cloud,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      weatherLoaded.weatherHeader.clouds.all +
                                          ' %',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    Text(
                                      'Cloudiness',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    WindIcon(
                                      degree: 90,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      weatherLoaded.weatherHeader.wind.speed +
                                          ' m/s',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    Text(
                                      'Wind',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(12)),
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    tanggal[0],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    tanggal[1].substring(0, 5),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 100,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      newMap['$date'].length,
                                                  itemBuilder: (context, i) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 20),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            newMap['$date'][i]
                                                                    ['dt_txt']
                                                                .toString()
                                                                .substring(
                                                                    11, 16),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                          Container(
                                                              width: 40,
                                                              height: 40,
                                                              child:
                                                                  Image.network(
                                                                "http://openweathermap.org/img/wn/${newMap['$date'][i]['weather'][0]['icon']}.png",
                                                                fit:
                                                                    BoxFit.fill,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high,
                                                              )),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                newMap['$date'][i]
                                                                            [
                                                                            'main']
                                                                        ['temp']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Icon(
                                                                WeatherIcons
                                                                    .celsius,
                                                                color: Colors
                                                                    .white,
                                                                size: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    tanggal2[0],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    tanggal2[1].substring(0, 5),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 100,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      newMap['$date2'].length,
                                                  itemBuilder: (context, i) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 20),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            newMap['$date2'][i]
                                                                    ['dt_txt']
                                                                .toString()
                                                                .substring(
                                                                    11, 16),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                          Container(
                                                              width: 40,
                                                              height: 40,
                                                              child:
                                                                  Image.network(
                                                                "http://openweathermap.org/img/wn/${newMap['$date2'][i]['weather'][0]['icon']}.png",
                                                                fit:
                                                                    BoxFit.fill,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high,
                                                              )),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                newMap['$date2'][i]
                                                                            [
                                                                            'main']
                                                                        ['temp']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Icon(
                                                                WeatherIcons
                                                                    .celsius,
                                                                color: Colors
                                                                    .white,
                                                                size: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    tanggal3[0],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    tanggal3[1].substring(0, 5),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 100,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      newMap['$date3'].length,
                                                  itemBuilder: (context, i) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 20),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            newMap['$date3'][i]
                                                                    ['dt_txt']
                                                                .toString()
                                                                .substring(
                                                                    11, 16),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                          Container(
                                                              width: 40,
                                                              height: 40,
                                                              child:
                                                                  Image.network(
                                                                "http://openweathermap.org/img/wn/${newMap['$date3'][i]['weather'][0]['icon']}.png",
                                                                fit:
                                                                    BoxFit.fill,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high,
                                                              )),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                newMap['$date3'][i]
                                                                            [
                                                                            'main']
                                                                        ['temp']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Icon(
                                                                WeatherIcons
                                                                    .celsius,
                                                                color: Colors
                                                                    .white,
                                                                size: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    tanggal4[0],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    tanggal4[1].substring(0, 5),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 100,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      newMap['$date4'].length,
                                                  itemBuilder: (context, i) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 20),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            newMap['$date4'][i]
                                                                    ['dt_txt']
                                                                .toString()
                                                                .substring(
                                                                    11, 16),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                          Container(
                                                              width: 40,
                                                              height: 40,
                                                              child:
                                                                  Image.network(
                                                                "http://openweathermap.org/img/wn/${newMap['$date4'][i]['weather'][0]['icon']}.png",
                                                                fit:
                                                                    BoxFit.fill,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high,
                                                              )),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                newMap['$date4'][i]
                                                                            [
                                                                            'main']
                                                                        ['temp']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Icon(
                                                                WeatherIcons
                                                                    .celsius,
                                                                color: Colors
                                                                    .white,
                                                                size: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    tanggal5[0],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    tanggal5[1].substring(0, 5),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            newMap['$date5'] == null
                                                ? Container()
                                                : Expanded(
                                                    child: Container(
                                                      height: 100,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            newMap['$date5']
                                                                .length,
                                                        itemBuilder:
                                                            (context, i) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  newMap['$date5']
                                                                              [
                                                                              i]
                                                                          [
                                                                          'dt_txt']
                                                                      .toString()
                                                                      .substring(
                                                                          11,
                                                                          16),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    child: Image
                                                                        .network(
                                                                      "http://openweathermap.org/img/wn/${newMap['$date5'][i]['weather'][0]['icon']}.png",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      filterQuality:
                                                                          FilterQuality
                                                                              .high,
                                                                    )),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      newMap['$date5'][i]['main']
                                                                              [
                                                                              'temp']
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    Icon(
                                                                      WeatherIcons
                                                                          .celsius,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 14,
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        )
                                      ],
                                    ))),
                    ],
                  ),
                )
              ],
            ),
          )
        ]);
      }
    }));
  }
}
