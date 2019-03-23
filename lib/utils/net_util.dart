import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../utils/tip_util.dart';

class NetUtil{
  static BaseOptions options = new BaseOptions(
    baseUrl: "http://111.231.70.170:8000",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {},
  );

  static String token = "Invalid";

  static Dio dio = new Dio(options);

  static void reset() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", "Invalid");
    token = preferences.get("token");
  }

  static void getUser(Function callBack) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    Options options = new Options(headers: {HttpHeaders.cookieHeader: token});
    Response response = await dio.get(
      "/user/info",
      options: options,
    );
    callBack(response.data);
  }

  static void modifyPwd(String oldPassword, String newPassword, Function callBack) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    Options options = new Options(headers: {HttpHeaders.cookieHeader: token});
    Response response = await dio.post(
      "/user/password",
      queryParameters: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      },
      options: options,
    );
    if(response.data["code"] == 200)
      callBack(true);
    else
      callBack(false);
  }

  static void login(String username, String password, Function callBack) async{
    Response response = await dio.post(
      "/user/login",
      queryParameters: {
        "username": username,
        "password": password,
      },
    );
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(response.data["code"] == 200){
      preferences.setString("token", response.headers["set-cookie"][0].split(';')[0]);
      callBack(true);
    }
    else{
      preferences.setString("token", "Invalid");
      callBack(false);
    }
    token = preferences.getString("token");
  }

  static void logout(Function callBack) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    if(token != "Invalid"){
      Options options = new Options(headers: {HttpHeaders.cookieHeader: token});
      Response response = await dio.post(
        "/user/logout",
        options: options,
      );
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", "Invalid");
      if(response.data["code"] == 200)
        callBack(true);
      else
        callBack(false);
    }
  }

  static void sendApplication(Map<String, dynamic> meetingInfo, List<Map<String, dynamic>> userInfo, Function callBack) async{
    Response response = await dio.post(
      "/meeting",
      data: meetingInfo,
    );
    if(response.data["code"] == 200){
      response = await dio.put(
        "/meeting/users",
        queryParameters: {
          "id": response.data["extras"]["meeting"]["id"],
        },
        data: userInfo,
      );
      if(response.data["code"] == 200){
        TipUtil.showTip("会议申请提交成功，请耐心等待审核");
        callBack(true);
      }
      else{
        TipUtil.showTip("绑定与会人员失败");
        callBack(false);
      }
    }
    else{
      TipUtil.showTip("会议时间冲突，请重新选择时间");
      callBack(false);
    }
  }

  static void modifyApplication(Map<String, dynamic> meetingInfo, List<Map<String, dynamic>> userInfo, Function callBack) async{
    Response response = await dio.put(
      "/meeting",
      data: meetingInfo,
    );
    if(response.data["code"] == 200){
      response = await dio.put(
        "/meeting/users",
        queryParameters: {
          "id": response.data["extras"]["meeting"]["id"],
        },
        data: userInfo,
      );
      if(response.data["code"] == 200){
        TipUtil.showTip("会议修改申请提交成功，请耐心等待审核");
        callBack(true);
      }
      else{
        TipUtil.showTip("绑定与会人员失败");
        callBack(false);
      }
    }
    else{
      TipUtil.showTip("会议时间冲突，请重新选择时间");
      callBack(false);
    }
  }

  static void getUnreadReminds(Function callBack) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    Options options = new Options(headers: {HttpHeaders.cookieHeader: token});
    Response response = await dio.get(
      "/user/reminds/unread",
      options: options,
    );
    if(response.data["code"] == 200)
      callBack(response.data["extras"]["reminds"].length);
    else
      callBack(-1);
  }

  static void getReminds(Function callBack) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    Options options = new Options(headers: {HttpHeaders.cookieHeader: token});
    Response response = await dio.get(
      "/user/reminds",
      options: options,
    );
    callBack(response.data);
  }

  static void get(String url, Function callBack, Map<String, dynamic> params) async{
    Response response = await dio.get(url, queryParameters: params);
    callBack(response.data);
  }

  static void post(String url, Function callBack, {Map<String, dynamic> data, Map<String, dynamic> params}) async{
    Response response = await dio.post(url, data: data, queryParameters: params);
    callBack(response.data);
  }

}