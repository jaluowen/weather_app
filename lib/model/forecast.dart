class ForecastHeader {
  String cod;
  String message;
  String cnt;
  List<ForecastList> list;
  City city;

  ForecastHeader({this.cod, this.message, this.cnt, this.list, this.city});

  ForecastHeader.fromJson(Map<String, dynamic> json) {
    cod = json['cod'].toString();
    message = json['message'].toString();
    cnt = json['cnt'].toString();
    if (json['list'] != null) {
      list = new List<ForecastList>();
      json['list'].forEach((v) {
        list.add(new ForecastList.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['message'] = this.message;
    data['cnt'] = this.cnt;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    return data;
  }
}

class ForecastList {
  String dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  Rain rain;
  Sys sys;
  String dtTxt;

  ForecastList(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.rain,
      this.sys,
      this.dtTxt});

  ForecastList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'].toString();
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    clouds =
        json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    rain = json['rain'] != null ? new Rain.fromJson(json['rain']) : null;
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds.toJson();
    }
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    if (this.rain != null) {
      data['rain'] = this.rain.toJson();
    }
    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    data['dt_txt'] = this.dtTxt;
    return data;
  }
}

class Main {
  String temp;
  String feelsLike;
  String tempMin;
  String tempMax;
  String pressure;
  String seaLevel;
  String grndLevel;
  String humidity;
  String tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toString();
    feelsLike = json['feels_like'].toString();
    tempMin = json['temp_min'].toString();
    tempMax = json['temp_max'].toString();
    pressure = json['pressure'].toString();
    seaLevel = json['sea_level'].toString();
    grndLevel = json['grnd_level'].toString();
    humidity = json['humidity'].toString();
    tempKf = json['temp_kf'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['sea_level'] = this.seaLevel;
    data['grnd_level'] = this.grndLevel;
    data['humidity'] = this.humidity;
    data['temp_kf'] = this.tempKf;
    return data;
  }
}

class Weather {
  String id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    main = json['main'].toString();
    description = json['description'].toString();
    icon = json['icon'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Clouds {
  String all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

class Wind {
  String speed;
  String deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toString();
    deg = json['deg'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    return data;
  }
}

class Rain {
  String d3h;

  Rain({this.d3h});

  Rain.fromJson(Map<String, dynamic> json) {
    d3h = json['3h'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['3h'] = this.d3h;
    return data;
  }
}

class Sys {
  String pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pod'] = this.pod;
    return data;
  }
}

class City {
  String id;
  String name;
  Coord coord;
  String country;
  String population;
  String timezone;
  String sunrise;
  String sunset;

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    country = json['country'].toString();
    population = json['population'].toString();
    timezone = json['timezone'].toString();
    sunrise = json['sunrise'].toString();
    sunset = json['sunset'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    data['country'] = this.country;
    data['population'] = this.population;
    data['timezone'] = this.timezone;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}

class Coord {
  String lat;
  String lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toString();
    lon = json['lon'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
