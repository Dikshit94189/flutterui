import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://picsum.photos/v2",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );

  Future<Response> getImages({int page = 1, int limit = 10}) async {
    return await _dio.get("/list?page=$page&limit=$limit");
  }
}