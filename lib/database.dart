
import 'package:appwrite/appwrite.dart';
import 'package:eventurapp/saved_data.dart';

import 'auth.dart';

String databaseId="6797c150000fd8bfe40c";

final Databases databases=Databases(client);

//save user data to appwrite database
Future <void> saveUserData(String name, String email, String userId) async {
  return await databases.createDocument(
      databaseId: databaseId,
      collectionId: "67ec10e4002754709764",
      documentId: ID.unique(),
      data: {
       "name":name,
       "email":email,
       "userId":userId,
      }).then((value)=> print("Document Created")).catchError((e)=>print(e));
}

//create new events
Future<void> createEvent(
    String name, String desc, String location, String datetime, String image,
    String createdBy, bool isInPersonOrNot, String actpoints, String price,
    )async{

  return await databases.createDocument(databaseId: databaseId,collectionId: "67a0e4c0002f07688c3c", documentId: ID.unique(),
      data: {
    "name":name,
    "description":desc,
    "image":image,
    "location":location,
    "datetime":datetime,
    "createdBy":createdBy,
    "isInPerson":isInPersonOrNot,
    "actpoints":actpoints,
    "price":price
  }).then((value)=>print("Event Created")).catchError((e)=>print(e));
}

//read all events
Future getAllEvents() async{
  try{
    final data=await databases.listDocuments(databaseId: databaseId, collectionId: "67a0e4c0002f07688c3c");
        return data.documents;
  } catch(e){
    print(e);
  }
}

//read hall mapping
Future getSeating() async{
  try{
    final data=await databases.listDocuments(databaseId: databaseId, collectionId: "67ed9478001271a609c6");
    return data.documents;
  } catch(e){
    print(e);
  }
}



//rsvp event
Future rsvpEvent(List participants, String documentId) async {
  final userId = SavedData.getUserId();
  participants.add(userId);
  try {
    await databases.updateDocument(
        databaseId: databaseId,
        collectionId: "67a0e4c0002f07688c3c",
        documentId: documentId,
        data: {"participants": participants});
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

//list events created by user
Future manageEvents() async{
  final userId = SavedData.getUserId();
  final userRole = SavedData.getUserRole();
  try{
    if (userRole.toLowerCase() == 'admin'){
      final data=await databases.listDocuments(databaseId: databaseId, collectionId: "67a0e4c0002f07688c3c");
    return data.documents;
    }
    else{
    final data=await databases.listDocuments(databaseId: databaseId, collectionId: "67a0e4c0002f07688c3c",
    queries: [Query.equal("createdBy", userId)]);
    return data.documents;
    }
  } catch(e){
    print(e);
  }
}

//update event
Future<void> updateEvent(
    String name, String desc, String location, String datetime, String image,
    String createdBy, bool isInPersonOrNot, String actpoints, String price, String docID,
    )async{

  return await databases.updateDocument(databaseId: databaseId,collectionId: "67a0e4c0002f07688c3c", documentId: docID,
      data: {
        "name":name,
        "description":desc,
        "image":image,
        "location":location,
        "datetime":datetime,
        "createdBy":createdBy,
        "isInPerson":isInPersonOrNot,
        "actpoints":actpoints,
        "price":price
      }).then((value)=>print("Event Updated")).catchError((e)=>print(e));
}

//deleting event
Future deleteEvent(String docID) async{
  try{
    final response = await databases.deleteDocument(databaseId: databaseId, collectionId: "67a0e4c0002f07688c3c", documentId: docID);
    print(response);
  }
  catch(e){
    print(e);
  }
}