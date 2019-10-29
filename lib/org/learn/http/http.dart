import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:flutter_app/org/learn/base/base_response.dart';
import 'package:flutter_app/org/learn/common/global.dart';
import 'package:flutter_app/org/learn/http/net_error.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    return options;
  }

  @override
  onResponse(Response response) {
    BaseRspData respData = BaseRspData.fromJson(response.data);
    if (respData.errorCode == BaseRspData.SUCCESS) {
      response.data = respData.data;
      return HttpRequest.dio().resolve(response);
    } else {
      throw ResponseException();
    }
  }
}

class HttpRequest {
  static Dio mDio;

  static Dio dio() {
    if (mDio == null) {
      String baseUrl;
      if (isRelease) {
        baseUrl = 'https://www.wanandroid.com/';
      } else {
        baseUrl = 'https://www.wanandroid.com/';
      }
      mDio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: 30000));
      if (!isRelease) {
        mDio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      }
      mDio.interceptors.add(ApiInterceptor());
      mDio.transformer = FlutterTransformer();
    }
    return mDio;
  }

  /*
   * error统一处理
   */
  static void _formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
      Fluttertoast.showToast(msg: "连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
      Fluttertoast.showToast(msg: "请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
      Fluttertoast.showToast(msg: "响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
      Fluttertoast.showToast(msg: "出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
      Fluttertoast.showToast(msg: "请求取消");
    } else if (e.error is SocketException) {
      print("连接网络异常");
      Fluttertoast.showToast(msg: "连接网络异常");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print('未知错误:$e');
    }
  }

/*
   * get请求
   */
  static dynamic get<T>(url, {queryParameters, options, cancelToken}) async {
    Response<T> response;
    try {
      response = await dio().get<T>(url, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
//      print('get success---------${response.statusCode}');
//      print('get success---------${response.data}');

//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码

    } on DioError catch (e) {
      _formatError(e);
      rethrow;
    }
    return response.data;
  }

  /*
   * post请求
   */
  static dynamic post<T>(url, {data, queryParameters, options, cancelToken}) async {
    Response<T> response;
    try {
      response = await dio()
          .post<T>(url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
    } on DioError catch (e) {
      _formatError(e);
    }
    return response.data;
  }
}
