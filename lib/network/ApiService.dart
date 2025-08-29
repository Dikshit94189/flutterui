import 'package:dio/dio.dart';

// https://picsum.photos/v2/list
class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://picsum.photos/v2",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );

  Future<Response> getImages({int page = 1, int limit = 20}) async {
    return await _dio.get("/list?page=$page&limit=$limit");
  }
}