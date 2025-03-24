import 'package:flutter_boilerplate/utils/log/app_log.dart';
import 'package:image_picker/image_picker.dart';

class FileService {
  static ImagePicker picker = ImagePicker();

  static Future<String?> openGallery() async {
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages == null) return null;

    appLog(getImages.path, source: "File Service");

    return getImages.path;
  }

  static Future<String?> openCamera() async {
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages == null) return null;

    appLog(getImages.path, source: "File Service");

    return getImages.path;
  }

  static Future<String?> getVideo() async {
    final XFile? getImages =
        await picker.pickVideo(source: ImageSource.gallery);
    if (getImages == null) return null;

    appLog(getImages.path, source: "File Service");

    return getImages.path;
  }
}
