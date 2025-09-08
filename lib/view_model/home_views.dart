import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/home_images.dart';
import '../repository/home_repository.dart';

// final imageViewModelProvider =
// StateNotifierProvider<ImageViewModel, AsyncValue<List<ImageModel>>>(
//       (ref) => ImageViewModel(ImageRepository()),
// );

// final imageViewModelProvider =
// StateNotifierProvider<ImageViewModel, AsyncValue<List<ImageModel>>>(
//       (ref) {
//     final notifier = ImageViewModel(ImageRepository());
//     return notifier;
//   },
// );

final imageViewModelProvider =
StateNotifierProvider.autoDispose<ImageViewModel, AsyncValue<List<ImageModel>>>(
      (ref) {
    final notifier = ImageViewModel(ImageRepository());
    ref.keepAlive(); // 👈 ensures provider stays alive
    return notifier;
  },
);

class ImageViewModel extends StateNotifier<AsyncValue<List<ImageModel>>> {
  final ImageRepository repository;

  ImageViewModel(this.repository) : super(const AsyncValue.loading()) {
    // Fetch once when provider is first created
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      final images = await repository.fetchImages();
      state = AsyncValue.data(images);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
