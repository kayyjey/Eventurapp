import 'package:eventurapp/views/homepage.dart';
import "package:flutter/material.dart";
import 'package:eventurapp/containers/custom_headtext.dart';
import 'package:eventurapp/constants/colors.dart';

class SeatingPage extends StatefulWidget {
  const SeatingPage({super.key});

  @override
  State<SeatingPage> createState() => _SeatingPageState();
}

class _SeatingPageState extends State<SeatingPage> {

  //enlarged image
  void showEnlargedImage(BuildContext context, String imageUrl) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Tap outside to close
      barrierLabel: "Image",
      pageBuilder: (_, __, ___) {
        return GestureDetector(
          onTap: () => Navigator.pop(context), // Tap anywhere to close
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.9), // Dark overlay
            body: Center(
              child: InteractiveViewer(
                panEnabled: true, // Enable panning
                boundaryMargin: EdgeInsets.all(20),
                minScale: 0.5,
                maxScale: 4.0,
                child: ClipRect( // Prevents rendering issues
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String seatingimage = "assets/test_event_images/hallmapping.jpg";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_outlined, size: 28, color: kLightGreen,),
                    ),
                    SizedBox(width: 10,),
                    CustomHeadtext(text: "Hall Mapping")
                  ],
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*.7,
                      decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => showEnlargedImage(context, seatingimage),
                          child: Image.asset(seatingimage),
                        ),
                      )
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Icon(Icons.image_outlined,size: 42,color: Colors.black,),
                    //     SizedBox(height: 8,),
                    //     Text("Event Image",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),)
                    //   ],
                    //)
                  ),
                ), //event image
              ]
          ),
        )

    );
  }
}