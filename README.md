# 采用的是Dio的3.x版本
目前基本功能可以使用, 未经过全面的应用和测试

# flutter_net_demo 

一个简单的flutter dio的封装, 包括: 日志打印, 网络进度, 返回json转bean, get post upload方法的封装, 简易可直接运行的demo

## Getting Started

Clone & Run main.dart
网络相关代码在net目录, 直接复制即可使用

## How to get bean

复制json字符串, 粘贴到[json to dart](https://javiercbk.github.io/json_to_dart/)的输入框, 点击Generate Dart之后就出现相应的Bean类, 粘贴到工程后再重命名

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
