import 'package:image_picker/image_picker.dart';

class PickImage {
  final ImagePicker _picker = ImagePicker();
  ImagePicker get picker => _picker;
  XFile? pickedImage;
  Future<void> pickImage(ImageSource source) async {
    try {
      XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        pickedImage = image;
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
}
