
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'clickpicture_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(alignment: Alignment.center,
        children: [

        Positioned(
          bottom: 25,


          child: MaterialButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>ClickImageScreen()));
          }
            ,

minWidth: 200,
            height: 45,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
              ,
              side: BorderSide(color: Colors.transparent),
            ),



            color: buttonColor,
            child: const Text("Share your meal",style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),),),
        ),
      ],

      ),
     );
  }
}
