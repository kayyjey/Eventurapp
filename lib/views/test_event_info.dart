import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/containers/custom_headtext.dart';
import 'package:flutter/material.dart';

class EventInfoPage extends StatefulWidget {
  const EventInfoPage({super.key});

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          ),
          child: Text("Enroll",style: TextStyle(color: Colors.white70,fontSize: 25,fontWeight: FontWeight.w900),),
        ),
      ),
        body: Padding(
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
                  CustomHeadtext(text: "Event Details")
                ],
              ),
              SizedBox(height: 12,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*.3,
                decoration: BoxDecoration(color: kLightGreen,borderRadius: BorderRadius.circular(8)),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined,size: 42,color: Colors.black,),
                    SizedBox(height: 8,),
                    Text("Event Image",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),)
                  ],
                )
              ), //event image
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Event Name :",style: TextStyle(color: kLightGreen,fontSize: 24,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Text("Drone Workshop",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Description :",style: TextStyle(color: kLightGreen,fontSize: 24,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Text("Create and fly drones",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      Text("Location :",style: TextStyle(color: kLightGreen,fontSize: 24,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Text("RSET",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Date & Time :",style: TextStyle(color: kLightGreen,fontSize: 24,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Text("21/02/2025 @ 10:20AM",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Activity Points :",style: TextStyle(color: kLightGreen,fontSize: 24,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Text("10",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Price :",style: TextStyle(color: kLightGreen,fontSize: 24,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Text("Rs.50",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(height: 30,),
                ]
              ),
            ]
          ),
        ),
    );
  }
}
