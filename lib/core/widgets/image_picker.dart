import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<File?> pickImage() async {
   
      File pickedImage;
      final imagePicker = ImagePicker();
      final picked = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      if (picked != null) {
        pickedImage = File(picked.path);
        return pickedImage;
      }
    
    return null;
  }

  Future<bool> _checkAndRequestPermission() async {
    var status = await Permission.photos.status;
    if (status.isGranted) {
      return true;
    } else {
      var result = await Permission.photos.request();
      return result.isGranted;
    }
  }
}
