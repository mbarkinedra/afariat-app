import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PublishadsImageViewController extends GetxController{
  File image;
  File   image2;




  void openCamera(int i ) async {
    var imgCamera = await  ImagePicker.pickImage(source: ImageSource.camera);
    if (i  == 1) {

      //  image = File(imgCamera.path);
        updateImage (image ,imgCamera);
    } else {

       //image = File(imgCamera.path);
       updateImage (image2,imgCamera);
    }
  }

  void openGallery(int i ) async {
    var imgGallery = await  ImagePicker.pickImage(source: ImageSource.gallery);
    if (i  == 1) {

      updateImage (image,imgGallery);

    } else {

        // image2 = File(imgGallery.path);
         updateImage (image2,imgGallery);
    }

    // Navigator.of(context).pop();
  }
  updateImage(image,imgGallery){
    image = File(imgGallery.path);
    update();
  }

}
