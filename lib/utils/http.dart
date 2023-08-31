import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_demo/utils/shared_data.dart';

class HttpUtil {
  static HttpUtil instance = HttpUtil();
  static late Dio dio;
  static late BaseOptions options;

  CancelToken cancelToken = CancelToken();

  /*
   * config it and create
   */
  HttpUtil() {
    String serverIp = SharedData.getString(SharedKey.serverIp) ?? '';
    String port = SharedData.getString(SharedKey.port) ?? '';
    String token = SharedData.getString(SharedKey.token) ?? '';
    String devSn = SharedData.getString(SharedKey.devSn) ?? '90E868344A9D';

    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      baseUrl: 'http://$serverIp:$port/fk',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: 'application/json',
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      // responseType: ResponseType.plain,
    );

    dio = Dio(options);

    /// 添加拦截器
    /// 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
    /// 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      options.headers['deviceCode'] = devSn;
      options.headers['token'] = token;
      return handler.next(options); //continue
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response); // continue
    }, onError: (DioException e, ErrorInterceptorHandler handler) {
      return handler.next(e);
    }));
  }

  /*
   * get请求
   */
  Future<Response?> get(url, {data, options, cancelToken}) async {
    Response? response;
    try {
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码
    } on DioException catch (e) {
      formatError(e);
    }
    return response;
  }

  /*
   * post请求
   */
  Future<Response?> post(url,
      {Object? data,
      Options? options,
      CancelToken? cancelToken,
      Map<String, dynamic>? queryParameters}) async {
    Response? response;
    try {
      response = await dio.post(url,
          data: data,
          options: options,
          cancelToken: cancelToken,
          queryParameters: queryParameters);
    } on DioException catch (e) {
      formatError(e);
    }
    return response;
  }

  /*
   * 下载文件
   */
  Future<Response?> downloadFile(urlPath, savePath) async {
    Response? response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        if (kDebugMode) {
          print("$count $total");
        }
      });
    } on DioException catch (e) {
      formatError(e);
    }
    return response?.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      if (kDebugMode) {
        print("连接超时");
      }
    } else if (e.type == DioExceptionType.sendTimeout) {
      if (kDebugMode) {
        print("请求超时");
      }
    } else if (e.type == DioExceptionType.receiveTimeout) {
      if (kDebugMode) {
        print("响应超时");
      }
    } else if (e.type == DioExceptionType.badResponse) {
      if (kDebugMode) {
        print("出现异常");
      }
    } else if (e.type == DioExceptionType.cancel) {
      if (kDebugMode) {
        print("请求取消");
      }
    } else {
      if (kDebugMode) {
        print("未知错误");
      }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
