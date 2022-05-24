import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  bool imagePicked = false;
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;

  Future<bool> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      Get.snackbar(
        "Uploading",
        "You have successfully selected your pic",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        borderRadius: 20,
        margin: const EdgeInsets.all(20),
      );
      _pickedImage = Rx<File?>(File(pickedImage.path));
      imagePicked = true;
    } else {
      imagePicked = false;
    }
    return imagePicked;
  }

  Future<String?> uploadToStorage() async {
    try {
      if (imagePicked) {
        Get.snackbar("Great", "uploading");

        final storage =
            FirebaseStorage.instanceFor(bucket: "gs://detect-game.appspot.com");
        Reference ref = storage.ref();
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        UploadTask uploadTask =
            ref.child("/$timestamp").putFile(File(_pickedImage.value!.path));
        TaskSnapshot snap = await uploadTask;
        String downloadUrl = await snap.ref.getDownloadURL();
        return downloadUrl;
      } else {
        Get.snackbar(
          "Error",
          "You have not selected any  pic",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          borderRadius: 20,
          margin: const EdgeInsets.all(20),
        );
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
