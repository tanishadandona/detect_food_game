import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import '../constants.dart';


class AuthController extends GetxController{
  static AuthController instance=Get.find();
  late Rx<User>_user;


late Rx<File?> _pickedImage;
File? get profilePhoto=>_pickedImage.value;
@override



  void pickImage()async{
final pickedImage=await ImagePicker().pickImage(source: ImageSource.camera);
if(pickedImage!=null){
  Get.snackbar("profile Picture", "You have successfully selected your profile pic");

}
_pickedImage=Rx<File?>(File(pickedImage!.path));


  }
  Future<String>_uploadToStorage(File image)async{
    Reference ref=firebaseStorage.ref().child("profilepic").child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask =ref.putFile(image);
    TaskSnapshot snap=await uploadTask;
    String downloadUrl=await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}