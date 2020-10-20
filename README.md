# flutter_net_demo 

一个简单的flutter dio的封装, 包括: 日志打印, 网络进度, 返回json转bean, get post upload方法的封装, 简易可直接运行的demo

## 采用的是Dio的3.x版本

包括get/post方法的使用, get方法可以直接在APP里运行, 
包括文件上传的使用方法, 文件上传接口的参数key是"files", 已经在net_service.dart文件中硬编码

## Dio的2.x版本的FlutterDioSample放在dio_2x分支上
链接:
[FlutterDioSample on dio_2x](https://github.com/HOLDfoot/FlutterDioSample/tree/dio_2x)
该版本不再维护


## Getting Started

Clone & Run main.dart
网络相关代码在net目录, 直接复制即可使用

## How to get bean

复制json字符串, 通过安装在IDE上的flutter插件"JsonToDartClass"生成工程中类似的WeatherBean

## How to use
### Config Common Params in basic_net_service.dart
 1. 通过getBasicUrl方法的返回值配置baseUrl
 2. 通过getHeaders配置基本header
 3. 通过getBasicParam配置基本网络参数

### Add network loading view in basic_net_service.dart
重写方法request, 在网络进行中加上loading, 如果要对后端返回值进行处理也可以放在这个地方

### Config server's request API in app_api.dart
For example:

```
static const String _GET_WEATHER = "/";
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
```
