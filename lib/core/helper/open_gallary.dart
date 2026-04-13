import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class OpenGallery {
  static Future<File?> openGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final File selectedImage = File(image.path);
      return selectedImage;
    }
    return null;
  }
}
