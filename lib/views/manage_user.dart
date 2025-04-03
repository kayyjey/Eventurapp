import 'package:appwrite/models.dart';
import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/database.dart';
import 'package:flutter/material.dart';

import '../saved_data.dart'; // Import SavedData

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  List<Document> userList = [];
  bool isLoading = true;
  String currentUserId = SavedData.getUserId(); // Get current user ID

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    manageUser().then((value) {
      userList = value;
      isLoading = false;
      setState(() {});
    });
  }

  Future<void> _updateUserRole(String userId, String newRole) async {
    await updateRole(userId, newRole);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Manage Users")),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          String currentRole = user.data["role"] ?? "Role N/A";
          String userId = user.data["userId"];
          bool isCurrentUser = userId == currentUserId;

          return Card(
            child: ListTile(
              title: Row(
                children: [
                  Text(user.data["name"]),
                  if (isCurrentUser)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "(You)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                ],
              ),
              subtitle: Text(user.data["email"]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentRole,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kLightGreen,
                    ),
                  ),
                  if (isCurrentUser) // Display an icon for the current user
                    IconButton(
                      icon: Icon(Icons.person_outline, size: 20, color: kLightGreen),
                      onPressed: () {},
                    )
                  else // Show edit button for other users
                    IconButton(
                      icon: Icon(Icons.edit_note, size: 20, color: kLightGreen),
                      onPressed: () {
                        _showRoleUpdateDialog(context, userId, currentRole);
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showRoleUpdateDialog(
      BuildContext context, String userId, String currentRole) {
    String newRole = currentRole;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update User Role"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                value: newRole,
                items: <String>['Student', 'Editor', 'Admin'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      newRole = newValue;
                    });
                  }
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _updateUserRole(userId, newRole);
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}