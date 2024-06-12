import 'package:delivery_kam/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static ApiService? _instance;
  final Dio _dio = Dio();
  String? _token;

  ApiService._() {
    initializeApiService();
  }

  factory ApiService() {
    return _instance ??= ApiService._();
  }

  Future<void> initializeApiService() async {
    _dio.options.baseUrl = AppConfig.apiUrl;
    _dio.options.headers['x-api-key'] = AppConfig.apiKey;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.validateStatus = (status) {
      return status! < 501;
    };
    _dio.interceptors.addAll([
      ErrorInterceptor(),
    ]);

    _token = await getToken();
    _dio.options.headers['Authorization'] = 'Bearer $_token';
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt_token');
    print(token);
    // Check if token is expired
    return token;
  }

  Future<Response> fetchData(String endPoint) async {
    if (_token == null) {
      await initializeApiService();
    }

    try {
      final response = await _dio.get(endPoint);
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

  Future<Response> postData(String endPoint, Object dataToSend) async {
    try {
      _token = await getToken();
      _dio.options.headers['Authorization'] = 'Bearer $_token';
      final response = await _dio.post(endPoint, data: dataToSend);
      return response;
    } catch (error) {
      if (error is DioException) {
        if (error.response?.data['detail'].runtimeType is String) {
          return Response(
              requestOptions: RequestOptions(path: endPoint),
              statusCode: 400,
              statusMessage:
                  error.response?.data['detail'] ?? 'Неизвестная ошибка');
        } else {
          return Response(
              requestOptions: RequestOptions(path: endPoint),
              statusCode: 400,
              statusMessage: 'Неизвестная ошибка');
        }
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
    if (!isValid) {throw DioException.badResponse(
        statusCode: status!,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    super.onResponse(response, handler);
  }
}
