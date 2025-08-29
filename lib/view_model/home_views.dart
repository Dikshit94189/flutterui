import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/home_images.dart';
import '../repository/home_repository.dart';

final imageViewModelProvider =
StateNotifierProvider<ImageViewModel, AsyncValue<List<ImageModel>>>(
      (ref) => ImageViewModel(ImageRepository()),
);

class ImageViewModel extends StateNotifier<AsyncValue<List<ImageModel>>> {
  final ImageRepository repository;

  ImageViewModel(this.repository) : super(const AsyncValue.loading()) {
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      final images = await repository.fetchImages();
      state = AsyncValue.data(images);
    } catch (e, st) {
      print("❌ Error fetching images: $e");
      state = AsyncValue.error(e, st);
    }
  }
}