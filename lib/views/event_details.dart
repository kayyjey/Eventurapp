import 'package:appwrite/models.dart';
import 'package:eventurapp/containers/format_datetime.dart';
import 'package:eventurapp/database.dart';
import 'package:eventurapp/saved_data.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  final Document data;
  const EventDetails({super.key, required this.data});


  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  bool isRSVPedEvent = false;
  String id = "";

  bool isUserPresent(List<dynamic> participants, String userId) {
    return participants.contains(userId);
  }

  @override
  void initState() {
    id = SavedData.getUserId();
    isRSVPedEvent = isUserPresent(widget.data.data["participants"], id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(253, 248, 246, 246),
              Color.fromARGB(0, 243, 243, 242),

            ])
        ),
        child: Column(
          children: [
            Stack(
              children: [Container(
                height: 300,
                width: double.infinity,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                  child: Image.network("https://cloud.appwrite.io/v1/storage/buckets/67a0ea89003df90b8242/files/${widget.data.data["image"]}/view?project=679780d900000280dfd0",
                  fit: BoxFit.cover,),
                ),
              ),
              Positioned(
                top: 30,left: 10,
                  child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,))),
                Positioned(
                  bottom: 60,
                  left: 20,
                  child: Row(children: [
                    Icon(Icons.calendar_month_outlined,size: 30,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text("${formatDate(widget.data.data["datetime"])}",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 14,),
                    Icon(Icons.access_time_outlined,size: 30,color: Colors.white,),
                    SizedBox(width: 8,),
                    Text("${formatTime(widget.data.data["datetime"])}",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(children: [
                    Icon(Icons.location_on_outlined,size: 30,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text("${widget.data.data["location"]}",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],),
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.data.data["name"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'vipinorg'),
                        ),
                      ),
                      Icon(Icons.share),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(widget.data.data["description"],style: TextStyle(color: Colors.black
                      , fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("ACTIVITY POINTS",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 22,fontFamily: 'vipinorg'),),
                  SizedBox(height: 10,),
                  Text("${widget.data.data["actpoints"]=="" ? "0" : widget.data.data["actpoints"]}",style: TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("PRICE",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 22,fontFamily: 'vipinorg'),),
                  SizedBox(height: 10,),
                  Text("${widget.data.data["price"]=="0" || widget.data.data["price"].toString().trim().isEmpty ? "FREE" : widget.data.data["price"]}",style: TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("MORE INFORMATION",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 22,fontFamily: 'vipinorg',),),
                  SizedBox(height: 10,),
                  Text("Event Type : ${widget.data.data["isInPerson"] == true? "In Person" : "Virtual"}",style: TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("Time : ${formatDate(widget.data.data["datetime"])}",style: TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("Location : ${widget.data.data["location"]}",style: TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("Current Participants : ${widget.data.data["participants"].length}",style: TextStyle(color: Colors.black, fontSize: 16),),
                  SizedBox(height: 35,),
                  isRSVPedEvent? SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.pink, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(35), // Same radius as button
                        ),
                        padding: EdgeInsets.all(3),
                      child: ElevatedButton(
                        onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("you are attending this event already"),));
                        },
                        child: Text("Attending Event",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),),
                      ),
                    ),
                  )):SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                      child: Container(decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.pink, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35), // Same radius as button
                      ),
                        padding: EdgeInsets.all(3),
                        child: ElevatedButton(
                          onPressed: (){
                            rsvpEvent(widget.data.data["participants"], widget.data.$id).then((value){
                              if(value){
                                setState(() {
                                  isRSVPedEvent=true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("RSVP Successful"),));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong"),));
                              }
                            });
                          },
                          child: Text("RSVP Event",
                            style: TextStyle(color:Colors.black, fontWeight: FontWeight.w500, fontSize: 18),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
