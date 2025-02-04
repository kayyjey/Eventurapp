import 'package:flutter/material.dart';
import '../auth.dart';
import 'homepage.dart';
import 'login.dart';

class CheckSessions extends StatefulWidget {
  const CheckSessions({super.key});

  @override
  State<CheckSessions> createState() => _CheckSessionsState();
}

class _CheckSessionsState extends State<CheckSessions> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    try {
      // Check if the user has an active session
      bool hasSession = await checkSessions();
      if (hasSession) {
        // Navigate to the homepage if a session exists
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        // Navigate to the login page if no session exists
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      // Handle errors, if any
      print("Error checking session: $e");
    } finally {
      // Ensure loading spinner stops if navigation fails
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox.shrink(); // Empty widget if not loading
  }
}
