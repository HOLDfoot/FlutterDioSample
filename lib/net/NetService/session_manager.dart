import 'package:dio/dio.dart';
import 'dart:io';

class SessionManager extends Dio {

  static const String CONTENT_TYPE_PRIMARY = "application";
  //static const String CONTENT_TYPE_FORM = "x-www-form-urlencoded"; // MediaType.parse("application/json; charset=UTF-8");
  static const String CONTENT_TYPE_JSON = "json";
  static const String CONTENT_CHART_SET = 'utf-8';

  // 工厂模式
  factory SessionManager() =>_getInstance();
  static SessionManager get instance => _getInstance();
  static SessionManager _instance;
  SessionManager._internal() {
    // 初始化
  }

  static SessionManager _getInstance() {
    if (_instance == null) {
      _instance =  SessionManager._internal();
      BaseOptions options = BaseOptions(
        // 15s 超时时间
          connectTimeout:15000,
          receiveTimeout:15000,
          responseType: ResponseType.json,
          contentType: ContentType(CONTENT_TYPE_PRIMARY, CONTENT_TYPE_JSON,charset: CONTENT_CHART_SET)
      );
      _instance.options = options;
    }
    return _instance;
  }
}