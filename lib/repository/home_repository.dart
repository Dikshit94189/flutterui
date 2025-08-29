
import '../models/home_images.dart';
import '../network/ApiService.dart';

class ImageRepository {
  final ApiService _apiService = ApiService();

  Future<List<ImageModel>> fetchImages({int page = 1, int limit = 10}) async {
    final response = await _apiService.getImages(page: page, limit: limit);

    print("✅ API Response: ${response.data}");

    final List<dynamic> data = response.data;
    return data.map((e) => ImageModel.fromJson(e)).toList();
  }
}