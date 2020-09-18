import 'dart:io';

import 'package:dio/dio.dart';

class DioInstance {

  static const String CONTENT_TYPE_PRIMARY = "application";
  //static const String CONTENT_TYPE_FORM = "x-www-form-urlencoded"; // MediaType.parse("application/json; charset=UTF-8");
  static const String CONTENT_TYPE_JSON = "json";
  static const String CONTENT_CHART_SET = 'utf-8';

  static Dio _instance;

  static Dio createInstance() {
    if (_instance == null) {
      BaseOptions options = BaseOptions(
        // 15s 超时时间
          connectTimeout:15000,
          receiveTimeout:15000,
          responseType: ResponseType.plain,
          contentType: "application/json; charset=utf-8;"
          //contentType: ContentType(CONTENT_TYPE_PRIMARY, CONTENT_TYPE_JSON,charset: CONTENT_CHART_SET)
      );
      _instance = new Dio(options);
    }
    return _instance;
  }
}