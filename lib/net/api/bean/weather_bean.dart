/// generate with json by https://javiercbk.github.io/json_to_dart/

/// 天气的返回对象
class WeatherBean {
  String msg;
  String success;
  List<Result> result;

  WeatherBean({this.success, this.result});

  WeatherBean.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String weaid;
  String days;
  String week;
  String cityno;
  String citynm;
  String cityid;
  String temperature;
  String humidity;
  String weather;
  String weatherIcon;
  String weatherIcon1;
  String wind;
  String winp;
  String tempHigh;
  String tempLow;
  String humiHigh;
  String humiLow;
  String weatid;
  String weatid1;
  String windid;
  String winpid;
  String weatherIconid;
  String weatherIconid1;

  Result(
      {this.weaid,
        this.days,
        this.week,
        this.cityno,
        this.citynm,
        this.cityid,
        this.temperature,
        this.humidity,
        this.weather,
        this.weatherIcon,
        this.weatherIcon1,
        this.wind,
        this.winp,
        this.tempHigh,
        this.tempLow,
        this.humiHigh,
        this.humiLow,
        this.weatid,
        this.weatid1,
        this.windid,
        this.winpid,
        this.weatherIconid,
        this.weatherIconid1});

  Result.fromJson(Map<String, dynamic> json) {
    weaid = json['weaid'];
    days = json['days'];
    week = json['week'];
    cityno = json['cityno'];
    citynm = json['citynm'];
    cityid = json['cityid'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    weather = json['weather'];
    weatherIcon = json['weather_icon'];
    weatherIcon1 = json['weather_icon1'];
    wind = json['wind'];
    winp = json['winp'];
    tempHigh = json['temp_high'];
    tempLow = json['temp_low'];
    humiHigh = json['humi_high'];
    humiLow = json['humi_low'];
    weatid = json['weatid'];
    weatid1 = json['weatid1'];
    windid = json['windid'];
    winpid = json['winpid'];
    weatherIconid = json['weather_iconid'];
    weatherIconid1 = json['weather_iconid1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weaid'] = this.weaid;
    data['days'] = this.days;
    data['week'] = this.week;
    data['cityno'] = this.cityno;
    data['citynm'] = this.citynm;
    data['cityid'] = this.cityid;
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['weather'] = this.weather;
    data['weather_icon'] = this.weatherIcon;
    data['weather_icon1'] = this.weatherIcon1;
    data['wind'] = this.wind;
    data['winp'] = this.winp;
    data['temp_high'] = this.tempHigh;
    data['temp_low'] = this.tempLow;
    data['humi_high'] = this.humiHigh;
    data['humi_low'] = this.humiLow;
    data['weatid'] = this.weatid;
    data['weatid1'] = this.weatid1;
    data['windid'] = this.windid;
    data['winpid'] = this.winpid;
    data['weather_iconid'] = this.weatherIconid;
    data['weather_iconid1'] = this.weatherIconid1;
    return data;
  }
}