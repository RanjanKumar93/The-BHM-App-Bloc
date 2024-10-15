import 'package:the_bhm_app_bloc/models/home_images.dart';

class HomeProvider {
  Future<HomeImagesModel> getImages() async {
    await Future.delayed(const Duration(seconds: 1));
    final HomeImagesModel placeholderImages = HomeImagesModel(data: [
      'https://via.placeholder.com/200',
      'https://via.placeholder.com/200',
      'https://via.placeholder.com/200',
    ]);
    return placeholderImages;
  }
}
