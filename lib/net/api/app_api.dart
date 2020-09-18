library basicnetservice;
export 'package:flutter_net_demo/net/service/net_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_net_demo/net/service/net_service.dart';

import 'app_net_service.dart';


class AppApi extends AppNetService {

  /// 获取天气的接口
  static const String _GET_WEATHER = "/";

  AppApi._();
  static AppApi _instance;
  static AppApi getInstance() {
    if (_instance == null) {
      _instance = AppApi._();
    }
    return _instance;
  }

  Future<ResultData> getWeather(BuildContext context, bool showProgress) async {
    Map<String, dynamic> param = {};
    ///?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json
    param["app"] = "weather.future";
    param["weaid"] = "1";
    param["appkey"] = "10003";
    param["sign"] = "b59bc3ef6191eb9f747dd4e83c99f2a4";
    param["format"] = "json";
    ResultData resultData =
    await get(_GET_WEATHER, params: param, context: context, showLoad: showProgress);
    resultData.toast();
    return resultData;
  }

}
