import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PublishImageViewController extends GetxController {
  File image;
  File image2;
  final picker = ImagePicker();

  void openCamera(int i) async {
    var imgCamera = await picker.getImage(source: ImageSource.camera);
    if (i == 1) {
      image = File(imgCamera.path);
      update();
    } else {
      image2 = File(imgCamera.path);
      update();
    }
  }

  void openGallery(int i) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (i == 1) {
      if (pickedFile != null) {
        print(' image selected.');
        image = File(pickedFile.path);
        update();
      } else {
        print('No image selected.');
      }
    } else {
      if (pickedFile != null) {
        print(' image selected.');
        image2 = File(pickedFile.path);
        update();
      } else {
        print('No image selected.');
      }
    }
  }
}
