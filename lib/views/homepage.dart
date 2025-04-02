import 'package:appwrite/models.dart';
import 'package:eventurapp/auth.dart';
import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/containers/event_container.dart';
import 'package:eventurapp/database.dart';
import 'package:eventurapp/views/create_event_page.dart';
import 'package:eventurapp/views/event_details.dart';
import 'package:eventurapp/views/login.dart';
import 'package:eventurapp/views/profile_page.dart';
import 'package:eventurapp/views/seating_page.dart';
import 'package:eventurapp/views/test_event_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../saved_data.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
String userName = "User";
String userRole = "Event Rep";
List<Document> events = [];
  @override
  void initState() {
    // TODO: implement initState
    userName=SavedData.getUserName();
    refresh();
    //userRole=SavedData.getUserRole();
    super.initState();
  }


  //refresh the home page
  void refresh(){
    getAllEvents().then((value) {
      events=value;
      setState(() {
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(253, 248, 246, 246),
                Color.fromARGB(0, 243, 243, 242),

              ])
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            toolbarHeight: 75,
            // leading: IconButton(
            //     onPressed: (){},
            //     icon: Icon(),color:,),
            actions: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: kLightGreen, // Background color
                  borderRadius: BorderRadius.circular(12), // Border radius
                ),
                child: Text(
                  '$userRole',
                  style: TextStyle(
                    color: Colors.black, // Text color
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),//Role Icon
              SizedBox(width: 10,),
              IconButton(
                  onPressed: (){
                    logoutUser();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SeatingPage()));
                  },
                  icon: Icon(Icons.contact_page_outlined,color: kLightGreen,size: 30,)
              ), //seating button
              SizedBox(width: 10,),
              FocusedMenuHolder(
                  blurSize: 4,
                  blurBackgroundColor: Colors.black,
                  menuWidth: MediaQuery.of(context).size.width * 0.7,
                  menuBoxDecoration: BoxDecoration(border: null,color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  menuItemExtent: 80,
                  menuOffset: 10,
                  animateMenuItems: true,
                  duration: Duration(milliseconds: 200),
                  openWithTap: true,
                  child: Icon(Icons.notifications_none_outlined,color: kLightGreen,size: 30,),
                  onPressed: (){},
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(title: Text("You have no notifications",style: TextStyle(color: oat1, fontSize: 14),), onPressed: (){}, trailingIcon: Icon(Icons.event_busy_outlined,color: oat1,), backgroundColor: kLightGreen)
                  ]),
              // IconButton(
              //     onPressed: (){},
              //     icon: Icon(Icons.notifications_none_outlined,color: kLightGreen,size: 30,)
              // ), //notification button

              SizedBox(width: 12,),
              IconButton(
                  onPressed: () async{
                    //logoutUser();
                   await Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                   refresh();
                },
                icon: Icon(Icons.account_circle_outlined,color: kLightGreen,size: 30,)
              ), //logout button
            ],
          ),
        ),
      ),
      body: //frontend demo start
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(253, 248, 246, 246),
              Color.fromARGB(0, 243, 243, 242),

            ])
        ),
        child: CustomScrollView(
          slivers: [
              //home layout code below
              SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text("Hi ${userName}"),
                    Text("Events Around You", style: TextStyle(color: brown1,fontSize: 18, fontWeight: FontWeight.w600),)
                  ],
                ),
              ),),
              SliverList(delegate: SliverChildBuilderDelegate((context,index) => EventContainer(data: events[index]),
              childCount: events.length
              ))

              //end of home layout code
            ],
        ),
      ),//end of front end only page
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         await Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateEventPage()));
         refresh();
        },
        child: Icon(Icons.add,color: Colors.black,),backgroundColor: kLightGreen,
      ),//add event button
    );
  }
}
