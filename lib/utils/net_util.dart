import 'package:dio/dio.dart';

class NetUitl{
  static BaseOptions options = new BaseOptions(
    baseUrl: "http://111.231.70.170:8000",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {},
  );

  static Dio dio = new Dio(options);

  static void get(String url, Function callBack, Map<String, dynamic> params) async{
    Response response = await dio.get(url, queryParameters: params);
    callBack(response.data);
  }

}

//class NetUtil{
//  static const String BaseUrl = "http://111.231.70.170:8000";
//  static const String GET = "get";
//  static const String POST = "post";
//
//  static void get(String url, Function callBack,
//      {Map<String, dynamic> params, Function errorCallBack}) async {
//    _request(BaseUrl + url, callBack, method: GET, params: params, errorCallBack: errorCallBack);
//  }
//
//  static void post(String url, Function callBack,
//      {Map<String, dynamic> params, Function errorCallBack}) async {
//    _request(url, callBack,
//        method: POST, params: params, errorCallBack: errorCallBack);
//  }
//
//  static void _request(String url, Function callBack,
//      {String method,
//        Map<String, dynamic> params,
//        Function errorCallBack}) async {
//    print("<net> url :<" + method + ">" + url);
//
//    if (params != null && params.isNotEmpty) {
//      print("<net> params :" + params.toString());
//    }
//
//    String errorMsg = "";
//    int statusCode;
//
//    try {
//      Response response;
//      if (method == GET) {
//        //组合GET请求的参数
//        if (params != null && params.isNotEmpty) {
//          StringBuffer sb = new StringBuffer("?");
//          params.forEach((key, value) {
//            sb.write("$key" + "=" + "$value" + "&");
//          });
//          String paramStr = sb.toString();
//          paramStr = paramStr.substring(0, paramStr.length - 1);
//          url += paramStr;
//        }
//        response = await Dio().get(url);
//      } else {
//        if (params != null && params.isNotEmpty) {
//          response = await Dio().post(url, data: params);
//        } else {
//          response = await Dio().post(url);
//        }
//      }
//
//      statusCode = response.statusCode;
//
//      //处理错误部分
//      if (statusCode < 0) {
//        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
//        _handError(errorCallBack, errorMsg);
//        return;
//      }
//
//      if (callBack != null) {
//        callBack(response.data["extras"]);
//        print("<net> response data:" + response.data["extras"]);
//      }
//    } catch (exception) {
//      _handError(errorCallBack, exception.toString());
//    }
//  }
//
//  static void _handError(Function errorCallback, String errorMsg) {
//    if (errorCallback != null) {
//      errorCallback(errorMsg);
//    }
//    print("<net> errorMsg :" + errorMsg);
//  }
//}