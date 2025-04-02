import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:eventurapp/auth.dart';
import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/containers/custom_headtext.dart';
import 'package:eventurapp/containers/custom_input_form.dart';
import 'package:eventurapp/database.dart';
import 'package:eventurapp/saved_data.dart';
import 'package:eventurapp/views/homepage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {

  FilePickerResult? _filePickerResult;
  bool _isInPersonEvent = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _activityPointsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();


  Storage storage = Storage(client);
  bool isUploading = false;

  String userId="";

  @override
  void initState(){
    super.initState();
    userId = SavedData.getUserId();
  }



  //get date and time from user
  Future <void> _selectDateTime(BuildContext context) async{
    final DateTime? pickedDateTime = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));

    if (pickedDateTime!=null){
      final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (pickedTime!=null){
        final DateTime selectedDateTime = DateTime(pickedDateTime.year, pickedDateTime.month, pickedDateTime.day, pickedTime.hour, pickedTime.minute);
        setState(() {
          _dateTimeController.text = selectedDateTime.toString();
        });

      }

    }
  }

  //function to open file picker
  void _openFilePicker() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      _filePickerResult = result;
    });
  }


  //upload event image to storage bucket
  Future uploadEventImage() async{
    setState(() {
      isUploading = true;
    });
    try{
      if(_filePickerResult!=null){
        PlatformFile file= _filePickerResult!.files.first;
        final fileBytes =  await File(file.path!).readAsBytes();
        final inputFile = InputFile.fromBytes(bytes: fileBytes, filename: file.name);

        final response = await storage.createFile(bucketId: "67a0ea89003df90b8242",fileId: ID.unique(),file: inputFile);
        print(response.$id);
        return response.$id;
      }
      else{
        print("Something went wrong");
      }
    }
    catch(e){
      print(e);
    } finally{
      setState(() {
        isUploading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(253, 239, 239, 239),
              Color.fromARGB(253, 207, 192, 180),

            ])
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                        icon: Icon(Icons.arrow_back_ios_new_outlined, size: 26, color: kLightGreen,),
                    ),
                    SizedBox(width: 10,),
                    CustomHeadtext(text: "Create Event"),
                  ],
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: ()=>_openFilePicker(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*.3,
                    decoration: BoxDecoration(color: kLightGreen,borderRadius: BorderRadius.circular(8)),
                    child: _filePickerResult!=null?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(image: FileImage(File(_filePickerResult!.files.first.path!)),
                      fit: BoxFit.fill,),
                    ):
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.add_a_photo_outlined,size: 42,color: Colors.black,),
                      SizedBox(height: 8,),
                      Text("Attach Image",style: TextStyle(fontFamily: 'Helio',color: Colors.black,fontWeight: FontWeight.w600),)
                    ],),
                  ),
                ),
                SizedBox(height: 8,),
                CustomInputForm(
                  controller: _nameController,
                  icon: Icons.event_outlined,label: "Event Name", hint: "Add an event name",),
                SizedBox(height: 8,),
                CustomInputForm(
                  maxLines: 4,
                  controller: _descController,
                  icon: Icons.description_outlined,label: "Description", hint: "Add a description",),
                SizedBox(height: 8,),
                CustomInputForm(
                  controller: _locationController,
                  icon: Icons.location_on_outlined,label: "Location", hint: "Enter location of event",),
                SizedBox(height: 8,),
                CustomInputForm(
                  controller: _dateTimeController,
                  icon: Icons.date_range_outlined,label: "Date & Time", hint: "Pick a Date & Time",
                  readOnly: true,
                  onTap: ()=>_selectDateTime(context),
                ),
                SizedBox(height: 8,),
                CustomInputForm(
                  controller: _activityPointsController,
                  icon: Icons.directions_run_outlined,label: "Activity Points", hint: "Enter the KTU points offered",),
                SizedBox(height: 8,),
                CustomInputForm(
                  controller: _priceController,
                  icon: Icons.attach_money_outlined,label: "Price", hint: "Enter the participation cost",
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Text("In Person Event", style: TextStyle(color: kLightGreen, fontSize: 20),),
                    Spacer(),
                    Switch(
                        activeColor: kLightGreen,
                        focusColor: Colors.black,
                        value: _isInPersonEvent, onChanged: (value){
                      setState(() {
                        _isInPersonEvent = value;
                      });
                    }),
                  ],
                ),
                SizedBox(height: 8,),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: MaterialButton(
                  color: kLightGreen,
                    onPressed: (){
                    if(_filePickerResult == null||_nameController.text==""||_descController.text==""||_locationController.text==""||_dateTimeController==""){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event Image,Event Name,Description,Location,Date & Time are required"),));
                    }
                    else {
                      uploadEventImage().then((value)=> createEvent(_nameController.text, _descController.text, _locationController.text, _dateTimeController.text, value,userId, _isInPersonEvent, _activityPointsController.text, _priceController.text))
                          .then((value)=> {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event Created")),),
                      Navigator.pop(context),
                      });
                    }
                    },
                  child: Text("Create New Event",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
