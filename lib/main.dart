import 'package:eventurapp/saved_data.dart';
import 'package:eventurapp/views/checkSessions.dart';
import 'package:eventurapp/views/homepage.dart';
import 'package:eventurapp/views/login.dart';
import 'package:eventurapp/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SavedData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(textTheme: GoogleFonts.interTextTheme()),
      home: const CheckSessions()
    );
  }
}

