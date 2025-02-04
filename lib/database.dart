
import 'package:appwrite/appwrite.dart';

import 'auth.dart';

String databaseId="6797c150000fd8bfe40c";

final Databases databases=Databases(client);

//save user data to appwrite database
Future <void> saveUserData(String name, String email, String userId) async {
  return await databases.createDocument(
      databaseId: databaseId,
      collectionId: "6797c15e0022f1ca60ae",
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
Future getAllEvents()async{
  try{
    final data=await databases.listDocuments(databaseId: databaseId, collectionId: "67a0e4c0002f07688c3c");
        return data.documents;
  } catch(e){
    print(e);
  }
}