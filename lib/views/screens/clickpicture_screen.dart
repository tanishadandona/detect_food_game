import 'package:camera/camera.dart';
import 'package:detectfood_game/views/screens/final_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:detectfood_game/main.dart';

class ClickImageScreen extends StatefulWidget {
  const ClickImageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ClickImageScreen> createState() => _ClickImageScreenState();
}

class _ClickImageScreenState extends State<ClickImageScreen> {
  late CameraController controller;
  bool? isimage;

  @override
  void initState() {
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      //onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: CircleAvatar(
                backgroundColor: buttonColor,
                radius: 25,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 30),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images.gif",
                height: 100,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  // color: borderColor,
                  height: 450,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  top: 20,
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipOval(
                      //radius: 100,
                      child: Align(
                          heightFactor: 0.5,
                          widthFactor: 0.9,
                          child: CameraPreview(controller)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Positioned(
                    bottom: 80,
                    child: Text(
                      "Click your meal",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Positioned(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () async {
                          bool imagePiked = await authController.pickImage();
                          if (imagePiked) {
                            await FirebaseAuth.instance.signInAnonymously();
                            String? imageUrl =
                                await authController.uploadToStorage();
                            if (imageUrl != null) {
                              Get.snackbar(
                                "Uploaded",
                                "Thank you for sharing food with me",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                borderRadius: 20,
                                margin: const EdgeInsets.all(20),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FinalScreen()));
                            } else {
                              Get.snackbar(
                                "Error",
                                "Something went wrong",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                borderRadius: 20,
                                margin: const EdgeInsets.all(20),
                              );
                            }
                          }
                        },
                        child: isimage != mounted
                            ? CircleAvatar(
                                backgroundColor: buttonColor,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              )
                            : Text("data")),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
