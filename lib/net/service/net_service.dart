library msnetservice;

export 'result_data.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_net_demo/net/api/net_config.dart';
import 'result_data.dart';
import 'dio_instance.dart';
import 'package:flutter/material.dart';

enum Method {
  GET,
  POST,
  UPLOAD,
  DOWNLOAD,
}

class NetService {
  static const String _TAG = "NetService";

  /// get请求
    get(String url,
      {Map<String, dynamic> params,
      BuildContext context,
      bool showLoad}) async {
    return await request(url,
        method: Method.GET,
        params: params,
        context: context,
        showLoad: showLoad);
  }

  /// post请求
  post(String url,
      {Map<String, dynamic> params,
      BuildContext context,
      bool showLoad}) async {
    return await request(url,
        method: Method.POST,
        params: params,
        context: context,
        showLoad: showLoad);
  }

  /// 附件上传
  upLoad(
    List<int> file,
    String fileName,
    String url, {
    Map<String, dynamic> params,
  }) async {
    return await request(url,
        method: Method.UPLOAD, params: params, file: file, fileName: fileName);
  }

  /// 附件下载
  download(String url, String savePath) async {
    return await request(url, method: Method.DOWNLOAD, fileSavePath: savePath);
  }

  ///  请求部分
  request(String url,
      {Method method,
      Map<String, dynamic> params,
      var file,
      String fileName,
      String fileSavePath,
      BuildContext context,
      bool showLoad = false}) async {
    try {
      Response response;

      Dio dioInstance = DioInstance.createInstance();
      var headers = await getHeaders();
      if (headers != null) {
        dioInstance.options.headers = headers;
      }
      var baseUrl = await getBasicUrl();
      dioInstance.options.baseUrl = baseUrl;

      // 打印网络日志
      StringBuffer requestParamLog = new StringBuffer();
      requestParamLog.write("$_TAG ");
      requestParamLog.write("Url:");
      requestParamLog.write(baseUrl);
      requestParamLog.write(url);
      requestParamLog.write("\n");
      requestParamLog.write("$_TAG ");
      requestParamLog.write("params:");
      requestParamLog.write(json.encode(params));
      printLog(requestParamLog.toString());

      switch (method) {
        case Method.GET:
          response = await dioInstance.get(url, queryParameters: params);
          break;
        case Method.POST:
          response = await dioInstance.post(url, data: params);
          break;
        case Method.UPLOAD:
          {
            FormData formData = new FormData();
            if (params == null) {
              params = {};
            }
            /// 第一个fileName是参数名, 必须和接口一致, 第二个fileName是文件的文件名
            params[fileName]  = MultipartFile.fromBytes(file, filename: fileName);
            formData = FormData.fromMap(params);
            // formData.add(
            //     fileName, UploadFileInfo.fromBytes(file, fileName)); /// 第一个fileName是参数名, 必须和接口一致, 第二个fileName是文件的文件名
            response = await dioInstance.post(url, data: formData);
            break;
          }
        case Method.DOWNLOAD:
          response = await dioInstance.download(url, fileSavePath);
          break;
      }
      return await handleDataSource(response, method, url: url);
    } catch (exception) {
      printLog("$_TAG net exception= " + exception.toString());
      return ResultData("网络连接异常", false, url: url);
    }
  }

  /// 数据处理
  static handleDataSource(Response response, Method method, {String url = ""}) {
    ResultData resultData;
    String errorMsg = "";
    int statusCode;
    statusCode = response.statusCode;
    printLog("$_TAG statusCode:" + statusCode.toString());
    if (method == Method.DOWNLOAD) {
      if (statusCode == 200) {
        /// 下载成功
        resultData = ResultData('下载成功', true);
      } else {
        /// 下载失败
        resultData = ResultData('下载失败', false);
      }
    } else {
      Map<String, dynamic> data;
      if (response.data is Map) {
        data = response.data;
      } else {
        data = json.decode(response.data);
      }
      if (isPrint()) {
        printBigLog("$_TAG data: ", json.encode(data));
      }

      //处理错误部分
      if (statusCode != 200) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        resultData = ResultData(errorMsg, false, url: url);
      } else {
        try {
          resultData = ResultData.response(data);
        } catch (exception) {
          resultData = ResultData(exception.toString(), true, url: url);
        }
      }
    }
    return resultData;
  }

  getHeaders() {
    return null;
  }

  getBasicUrl() {
    return null;
  }

  static void printLog(String log, {tag}) {
    bool print = isPrint();
    if (print) {
      String tagLog;
      if (tag != null) {
        tagLog = tag + log;
      } else {
        tagLog = log;
      }
      debugPrint(tagLog);
    }
  }

  static void printBigLog(String tag, String log) {
    //log = TEST_POEM;
    bool print = isPrint();
    const MAX_COUNT = 800;
    if (print) {
      if (log != null && log.length > MAX_COUNT) {
        // 超过1000就分次打印
        int len = log.length;
        int paragraphCount = ((len / MAX_COUNT) + 1).toInt();
        for (int i = 0; i < paragraphCount; i++) {
          int printCount = MAX_COUNT;
          if (i == paragraphCount -1) {
            printCount = len - (MAX_COUNT * (paragraphCount -1));
          }
          String finalTag = "" + tag + "\n";
          printLog(log.substring(i * MAX_COUNT, i * MAX_COUNT + printCount) + "\n", tag: finalTag);
        }
      } else {
        String tagLog;
        if (tag == null) {
          tagLog = tag + log;
        } else {
          tagLog = log;
        }
        printLog(tagLog);
      }
    }
  }

  static bool isPrint() {
    return NetConfig.DEBUG;
  }
}
