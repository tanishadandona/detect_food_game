import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'controllers/auth_controller.dart';

//COLors

var buttonColor=Colors.green[400];
const borderColor=Colors.grey;
const textColor= Colors.white;

//Firebase
var firebaseAuth=FirebaseAuth.instance;
var firebaseStorage=FirebaseStorage.instance;
var firestore=FirebaseFirestore.instance;


//Controller
var authController=AuthController.instance;