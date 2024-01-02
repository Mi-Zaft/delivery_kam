import 'package:delivery_kam/constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    // Конфигурируйте ваш экземпляр Dio здесь
    // Например, установите базовый URL API, заголовки и т.д.
    _dio.options.baseUrl = AppConfig.apiUrl;
    _dio.options.headers['x-api-key'] = AppConfig.apiKey;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.validateStatus = (status) {
      return status! < 501;
    };
    _dio.interceptors.addAll([
      ErrorInterceptor(),
    ]);
    // _dio.options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
  }

  Future<Response> fetchData(String endPoint) async {
    try {
      final response = await _dio.get(endPoint);
      return response;
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  Future<Response> postData(String endPoint, Object dataToSend) async {
    try {
      print(dataToSend);
      final response = await _dio.post(endPoint, data: dataToSend);
      return response;
    } catch (error) {
      if (error is DioException) {
        return Response(
            requestOptions: RequestOptions(path: endPoint),
            statusCode: 400,
            statusMessage:
                error.response?.data['detail'] ?? 'Неизвестная ошибка');
      } else {
        return Response(
            requestOptions: RequestOptions(path: endPoint),
            statusCode: 400,
            statusMessage: 'Error: $error');
      }
    }
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 300;
    if (!isValid) {
      throw DioException.badResponse(
        statusCode: status!,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    super.onResponse(response, handler);
  }
}
