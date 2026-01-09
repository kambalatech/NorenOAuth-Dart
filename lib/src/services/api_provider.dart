import 'dart:convert';
import 'package:dio/dio.dart';

class NorenApiProvider {
  late final Dio dio;
  final String apiOk = 'Ok';
  final String apiNotOk = 'Not_Ok';
  final String loginUrl = 'GenAcsTok';
  final String lmts = 'Limits';

  NorenApiProvider({required String baseUrl}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );
    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              options.data = 'jData=${jsonEncode(options.data)}';
              return handler.next(options);
            },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          DioException customError = DioException(
            requestOptions: error.requestOptions,
            response: error.response,
            type: error.type,
            error: error.error,
            stackTrace: error.stackTrace,
            message: error.type == DioExceptionType.connectionTimeout
                ? 'Connection timeout'
                : error.type == DioExceptionType.receiveTimeout
                ? 'Receive timeout'
                : (error.response?.data is Map<String, dynamic>
                      ? (error.response?.data['emsg'] ??
                            error.response?.statusMessage)
                      : (error.response?.statusMessage ??
                            error.response?.data?.toString() ??
                            error.message)),
          );
          if (error.response?.statusCode == 401) {
            // Handle unauthorized access, e.g., redirect to login
          }

          return handler.next(customError);
        },
      ),
    );
  }

  Future<dynamic> post(String endpoint, Object data, accessToken) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: accessToken != null
            ? Options(headers: {'Authorization': 'Bearer $accessToken'})
            : null,
      );
      return response.data;
    } on DioException catch (e) {
      return {'stat': apiNotOk, 'emsg': e.message.toString()};
    } catch (e) {
      return {'stat': apiNotOk, 'emsg': e.toString()};
    }
  }
}
