import 'package:appwrite/models.dart';
import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/database.dart';
import 'package:eventurapp/saved_data.dart';
import 'package:eventurapp/views/event_details.dart';
import 'package:flutter/material.dart';

class RSVPEvents extends StatefulWidget {
  const RSVPEvents({super.key});

  @override
  State<RSVPEvents> createState() => _RSVPEventsState();
}

class _RSVPEventsState extends State<RSVPEvents> {
  List<Document> events = [];
  List<Document> userEvents = [];

  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh(){
    String userId=SavedData.getUserId();
    getAllEvents().then((value) {
      events=value;
      for(var event in events){
        List<dynamic> participants=event.data["participants"];
        if(participants.contains(userId)){
          userEvents.add(event);
        }
        setState(() {
          isLoading = false;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("RSVP Events",style: TextStyle(color: kLightGreen),),),
    body: ListView.builder(
        itemCount: userEvents.length,
        itemBuilder: (context,index) => Card(child: ListTile(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetails(data: userEvents[index]))),
          title: Text(userEvents[index].data["name"]),
          subtitle: Text(userEvents[index].data["location"]),
          trailing: Icon(Icons.check_circle,color: kLightGreen,),
        ))),
    );
  }
}
