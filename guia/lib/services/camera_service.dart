import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _image = ImagePicker();

  Future<File?> chamarGaleria() async {
    final XFile? image = await _image.pickImage(source: ImageSource.gallery);
    if(image == null) return null;
    return File(image.path);
  }

  Future<File?> chamarCamera() async {
    final XFile? image = await _image.pickImage(source: ImageSource.camera);
    if(image == null) return null;
    return File(image.path);
  }
}
