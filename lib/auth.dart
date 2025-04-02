import 'package:appwrite/appwrite.dart';
import 'package:eventurapp/database.dart';
import 'package:eventurapp/saved_data.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1') // Replace with your Appwrite server URL
    .setProject('679780d900000280dfd0') // Replace with your project ID
    .setSelfSigned(status: true);

// Use the client for making requests

//create account
Account account = Account(client);
Future <String> createUser(String name, String email, String password) async {
  try {
    final user = await account.create(
      userId: ID.unique(),  // Unique user ID
      email: email,          // Email from the parameter
      password: password,    // Password from the parameter
      name: name, // Name from the parameter
    );
    saveUserData(name, email, user.$id,);
    return "success";
  }
  on AppwriteException catch(e){
    return e.message.toString();
  }
}


//Login
Future loginUser(String email, String password) async {
  try{
    final user = await account.createEmailSession(email: email, password: password);
    SavedData.saveUserId(user.userId);
    getUserData();
    return true;
  }
  on AppwriteException catch(e){
    return false;
  }
}

//logout
Future logoutUser() async {
  await account.deleteSession(sessionId: 'current');
  print("Logout process complete");
}

//check if use has active session
Future<bool> checkSessions() async {
  try {
    await account.getSession(sessionId: 'current');
    return true; // Session exists
  } catch (e) {
    print("No active session: $e");
    return false; // No session
  }
}


//get user data from the database
Future getUserData() async{
  final id = SavedData.getUserId();
  try{
    final data = await databases.listDocuments(databaseId: databaseId, collectionId: "67ec10e4002754709764",
    queries: [Query.equal("userId", id)]);

    SavedData.saveUserName(data.documents[0].data['name']);
    SavedData.saveUserEmail(data.documents[0].data['email']);
    SavedData.saveUserRole(data.documents[0].data['role']);
    print(data);
  } catch(e){
    print(e);
  }
}