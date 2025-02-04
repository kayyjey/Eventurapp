import 'package:eventurapp/auth.dart';
import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/views/create_event_page.dart';
import 'package:eventurapp/views/login.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    userName=SavedData.getUserName();
    //userRole=SavedData.getUserRole();
    super.initState();
  }

  //event images and text
//upcoming
  String event1_date = "21 February";
  String event1_image = "assets/test_event_images/drone.jpg";
  String event1_text = "Drone Workshop";

  String event2_date = "26 February";
  String event2_image = "assets/test_event_images/quiz_image.jpg";
  String event2_text = "Quiz Competition";

  String event3_date = "3 March";
  String event3_image = "assets/test_event_images/music_fest.jpg";
  String event3_text = "Music Fest";

  String event4_date = "7 March";
  String event4_image = "assets/test_event_images/farewell.jpg";
  String event4_text = "Farewell Party";

  //popular events
  String popular1_date = "1 March";
  String popular1_image = "assets/test_event_images/grand_prix.jpg";
  String popular1_text = "RSET Grand Prix";

  String popular2_date = "2 March";
  String popular2_image = "assets/test_event_images/stargaze.jpg";
  String popular2_text = "Stargazing with Telescope";

  String popular3_date = "15 February";
  String popular3_image = "assets/test_event_images/solo_level.jpg";
  String popular3_text = "Solo Leveling Screening";

  String popular4_date = "5 April";
  String popular4_image = "assets/test_event_images/fc25.jpg";
  String popular4_text = "FC25 Tournament";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                FocusedMenuItem(title: Text("You have no notifications",style: TextStyle(color: kLightGreen, fontSize: 14),), onPressed: (){}, trailingIcon: Icon(Icons.event_busy_outlined,color: kLightGreen,), backgroundColor: Colors.black87)
              ]),
          // IconButton(
          //     onPressed: (){},
          //     icon: Icon(Icons.notifications_none_outlined,color: kLightGreen,size: 30,)
          // ), //notification button

          SizedBox(width: 12,),
          IconButton(
              onPressed: (){
                logoutUser();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon: Icon(Icons.logout,color: kLightGreen,size: 30,)
          ), //logout button
        ],
      ),
      body: //frontend demo start
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //welcome text
            Row(
              children: [
                SizedBox(width: 8,),
                Text("Hi, $userName",style: TextStyle(color: kLightGreen,fontSize: 32,fontWeight: FontWeight.w600)),
              ],
            ),
            //sample search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      hintText: "Search for events . . .",
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        //controller.openView();
                      },
                      onChanged: (_) {
                        //controller.openView();
                      },
                      leading: const Icon(Icons.search, color: kLightGreen,),
                      textStyle: WidgetStateProperty.all(TextStyle(color: kLightGreen,fontSize: 20)),// Change text color
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  },
              ),
            ),//end of search bar
            //upcoming events text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Upcoming Events",style: TextStyle(color: kLightGreen,fontSize: 24,fontWeight: FontWeight.w600),),
                  TextButton(onPressed: (){}, child: Text("See all", style: TextStyle(color: kLightGreen, fontSize: 17,),))
                ],
              ),
            ),
            //upcoming events carrousel
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventInfoPage()),
                        );
                      },
                      child: Container(
                        width: 250,
                        height: 170,
                        child: Stack(
                          children: [
                            // Background Image
                            Positioned.fill(
                              child: Image.asset(
                                  event1_image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Semi-transparent overlay (optional)
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withOpacity(0.3), // Adjust opacity if needed
                              ),
                            ),
                            // Text on top of image
                            Positioned(
                              bottom: 10, // Adjust position as needed
                              left: 10,   // Adjust position as needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event1_date,  // Change this to your event name
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black45,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    event1_text,  // Change this to your event name
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventInfoPage()),
                        );
                      },
                      child: Container(
                        width: 250,
                        height: 170,
                        child: Stack(
                          children: [
                            // Background Image
                            Positioned.fill(
                              child: Image.asset(
                                event2_image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Semi-transparent overlay (optional)
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withOpacity(0.3), // Adjust opacity if needed
                              ),
                            ),
                            // Text on top of image
                            Positioned(
                              bottom: 10, // Adjust position as needed
                              left: 10,   // Adjust position as needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event2_date,  // Change this to your event name
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black45,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    event2_text,  // Change this to your event name
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventInfoPage()),
                        );
                      },
                      child: Container(
                        width: 250,
                        height: 170,
                        child: Stack(
                          children: [
                            // Background Image
                            Positioned.fill(
                              child: Image.asset(
                                event3_image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Semi-transparent overlay (optional)
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withOpacity(0.3), // Adjust opacity if needed
                              ),
                            ),
                            // Text on top of image
                            Positioned(
                              bottom: 10, // Adjust position as needed
                              left: 10,   // Adjust position as needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event3_date,  // Change this to your event name
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black45,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    event2_text,  // Change this to your event name
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventInfoPage()),
                        );
                      },
                      child: Container(
                        width: 250,
                        height: 170,
                        child: Stack(
                          children: [
                            // Background Image
                            Positioned.fill(
                              child: Image.asset(
                                event4_image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // Semi-transparent overlay (optional)
                            Positioned.fill(
                              child: Container(
                                color: Colors.black.withOpacity(0.3), // Adjust opacity if needed
                              ),
                            ),
                            // Text on top of image
                            Positioned(
                              bottom: 10, // Adjust position as needed
                              left: 10,   // Adjust position as needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event4_date,  // Change this to your event name
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black45,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    event2_text,  // Change this to your event name
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            //popular events text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Popular Events",style: TextStyle(color: kLightGreen,fontSize: 24,fontWeight: FontWeight.w600,),),
                  TextButton(onPressed: (){}, child: Text("See all", style: TextStyle(color: kLightGreen, fontSize: 17,decoration: TextDecoration.underline),))
                ],
              ),
            ),
            //popular events list
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventInfoPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      child: Stack(
                        children: [
                          // Background Image
                          Positioned.fill(
                            child: Image.asset(
                              popular1_image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Semi-transparent overlay (optional)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.3), // Adjust opacity if needed
                            ),
                          ),
                          // Text on top of image
                          Positioned(
                            bottom: 10, // Adjust position as needed
                            left: 10,   // Adjust position as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  popular1_date,  // Change this to your event name
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  popular1_text,  // Change this to your event name
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventInfoPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      child: Stack(
                        children: [
                          // Background Image
                          Positioned.fill(
                            child: Image.asset(
                              popular2_image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Semi-transparent overlay (optional)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.3), // Adjust opacity if needed
                            ),
                          ),
                          // Text on top of image
                          Positioned(
                            bottom: 10, // Adjust position as needed
                            left: 10,   // Adjust position as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  popular2_date,  // Change this to your event name
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  popular2_text,  // Change this to your event name
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventInfoPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      child: Stack(
                        children: [
                          // Background Image
                          Positioned.fill(
                            child: Image.asset(
                              popular3_image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Semi-transparent overlay (optional)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.3), // Adjust opacity if needed
                            ),
                          ),
                          // Text on top of image
                          Positioned(
                            bottom: 10, // Adjust position as needed
                            left: 10,   // Adjust position as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  popular3_date,  // Change this to your event name
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  popular3_text,  // Change this to your event name
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventInfoPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      child: Stack(
                        children: [
                          // Background Image
                          Positioned.fill(
                            child: Image.asset(
                              popular4_image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Semi-transparent overlay (optional)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.3), // Adjust opacity if needed
                            ),
                          ),
                          // Text on top of image
                          Positioned(
                            bottom: 10, // Adjust position as needed
                            left: 10,   // Adjust position as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  popular4_date,  // Change this to your event name
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  popular4_text,  // Change this to your event name
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ],
        ),
      ),//end of front end only page
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateEventPage()));
        },
        child: Icon(Icons.add,color: Colors.black,),backgroundColor: kLightGreen,
      ),//add event button
    );
  }
}
