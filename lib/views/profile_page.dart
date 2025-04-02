import 'package:eventurapp/auth.dart';
import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/saved_data.dart';
import 'package:eventurapp/views/login.dart';
import 'package:eventurapp/views/manage_events.dart';
import 'package:eventurapp/views/rsvp_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    name = SavedData.getUserName();
    email = SavedData.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: brown1, fontWeight: FontWeight.w800 ,fontSize: 24),),
                Text(email, style: TextStyle(color: brown1, fontWeight: FontWeight.w500 ,fontSize: 18),)
              ]
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: oat1,borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>RSVPEvents())),title: Text("RSVP Events",style: TextStyle(color: brown1),),),
                ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageEvents())),title: Text("Manage Events",style: TextStyle(color: brown1),),),
                ListTile(onTap: (){
                  logoutUser();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },title: Text("Logout",style: TextStyle(color: brown1),),),
            
              ],),
            ),
          )
        ],
      ),
    );
  }
}
