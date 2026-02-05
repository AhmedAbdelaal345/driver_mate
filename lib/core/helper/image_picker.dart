import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
static Future<String?> pickImageAsString() async {
  final ImagePicker picker = ImagePicker();

  final XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
  );

  if (image != null) {
    return image.path; // String
  }
  return null;
}
}
