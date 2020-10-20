library basicnetservice;

export 'package:flutter_net_demo/net/service/net_service.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_net_demo/net/service/net_service.dart';
import 'package:flutter_net_demo/net/widget/dialog_param.dart';
import 'package:flutter_net_demo/net/widget/loading_dialog.dart';

import 'app_net_service.dart';

class AppApi extends AppNetService {
  /// 获取天气的接口
  static const String _GET_WEATHER = "/";
  static const String _SIGN_UP = "/signup";
  static const String _SIGN_IN = "/signin";
  static const String _GET_USER_MINE = "/get_user_mine";
  static const String _UPLOAD_USER_ICON = "/upload_photo";
  static const String _UPDATE_USER = "/update_user";

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
    ResultData resultData = await get(_GET_WEATHER,
        params: param, context: context, showLoad: showProgress);
    return resultData;
  }

  /// 上传头像接口
  Future<ResultData> uploadUserIcon(BuildContext context, File file) async {
    // 开始进度
    ShowParam showParam =
    new ShowParam(barrierDismissible: true, showBackground: true);
    showParam.text = "正在上传头像...";
    LoadingDialogUtil.showTextLoadingDialog(context, showParam);
    String fileName = file.path.substring(file.path.lastIndexOf("/") + 1);
    print("filename: $fileName");
    List<int> bytes = await file.readAsBytes();
    ResultData resultData = await upLoad(file, fileName, _UPLOAD_USER_ICON);
    showParam.pop();
    // 结束进度
    resultData.toast();
    return resultData;
  }
}
