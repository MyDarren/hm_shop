// 基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio(); // dio请求对象
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _addInterceptor();
  }

  // 拦截器
  void _addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      handler.next(request);
    }, onResponse: (response, handler) {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        handler.next(response);
        return;
      }
      handler.reject(DioException(requestOptions: response.requestOptions));
    }, onError: (error, handler) {
      handler.reject(error);
    }));
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // 进一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        // 才认定http状态和业务状态均正常，就可以正常的放行通过
        return data["result"];
      }
      throw Exception(data["msg"] ?? "加载数据异常");
    } catch (e) {
      throw Exception(e);
    }
  }
}

final diorequest = DioRequest();
// dio请求工具发出请求，返回的数据 Response<dynamic>.data
// 把所有接口的data解放出来，拿到真正的数据，要判断业务状态码是不是等于1
