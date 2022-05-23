
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class ClickImageScreen extends StatefulWidget {
 // final List<CameraDescription>?cameras;
 //  CameraController controller;
 //  bool _isReady = false;
  //final List<CameraDescription>? cameras;
   ClickImageScreen({Key? key,}) : super(key: key);

  @override
  State<ClickImageScreen> createState() => _ClickImageScreenState();
}
@override
// void initState() {
//   // TODO: implement initState
//   var initState = super.initState();
//   _setUpCamera();
// }
//
// void _setUpCamera() async {
//   try {
//     // initialize cameras.
//     cameras = await availableCameras();
//     // initialize camera controllers.
//     // Current bug for high / medium with samsung devices.
//     controller = CameraController(
//       cameras[0],
//       ResolutionPreset.medium,
//     );
//
//     await controller.initialize();
//   } on CameraException catch (_) {
//     // do something on error.
//   }
//   if (!mounted) return;
//   setState(() {
//     _isReady = true;
//   });
// }

class _ClickImageScreenState extends State<ClickImageScreen> {
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(padding: EdgeInsets.only(left: 20,top: 20),

              child: CircleAvatar(backgroundColor: buttonColor,radius: 25,
                child: InkWell(onTap: (){Navigator.pop(context);},
                  child: const Icon(Icons.arrow_back,color: Colors.white,
                  size: 30),
                ),
              ),
            ),

            SizedBox(height: 25,),


          Align(alignment: Alignment.topRight,
            child:   Image.asset("assets/images.gif",height: 100,),),
            Stack(alignment: Alignment.center,
             children: [
               Container(
              // color: borderColor,
              height: 450,
              decoration: const BoxDecoration(color: Colors.grey,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
              ),
            ),
          const  Positioned(bottom: 30,
               top: 20,
               child: Align(alignment: Alignment.center,
                 child:  CircleAvatar(
                     radius: 100,
                     backgroundColor: Colors.black26,
                   ),
               ),
            ),
              const SizedBox(height: 30,),
              const Positioned(bottom: 80,

                   child: Text("Click your meal",style: TextStyle(
                     fontWeight: FontWeight.w800,
                     fontSize: 20,
                   ),)),
               const SizedBox(height: 30,),
               Positioned(bottom: 10,
                 child: Align(alignment: Alignment.center,
                     child: CircleAvatar(backgroundColor: buttonColor,
                       child: InkWell(
                         onTap: (){
authController.pickImage();
                          // authController.profilePhoto;
                           print("Camera clicked");
                         },
                         child: Icon(Icons.camera_alt,size: 30,
                         color: Colors.white,),
                       ),radius: 30,)),
               )
             ],
            )
          ],
        ),
      ),
    );
  }
}
