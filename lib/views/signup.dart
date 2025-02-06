import 'package:eventurapp/auth.dart';
import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../containers/custom_input_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(253, 248, 246, 246),
                Color.fromARGB(0, 243, 243, 242),

              ])
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 1),
                child: Text("SIGN UP",style: TextStyle(color: brown1, fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(height: 2,),
              CustomInputForm(
                controller: _nameController,
                icon: Icons.person_outline, label: "Name", hint: "Enter your name",),
              SizedBox(height: 2,),
              CustomInputForm(
                controller: _emailController,
                icon: Icons.email_outlined, label: "Email", hint: "Enter your email",),
              SizedBox(height: 2,),
              CustomInputForm(
                obscureText: true,
                controller: _passwordController,
                icon: Icons.lock_outline_rounded, label: "Password", hint: "Enter your Password",),
              SizedBox(height: 24,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                    child: ElevatedButton(onPressed: (){
                      createUser(_nameController.text, _emailController.text, _passwordController.text).
                      then((value){
                        if(value == "success"){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created")));
                          Future.delayed(Duration(seconds: 2),()=>
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()))
                          );
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                        }
                      });
                    },
                      child: Text("Sign Up"),
                      style: OutlinedButton.styleFrom(foregroundColor: brown1,elevation: 10,
                          backgroundColor: Color.fromARGB(255, 251, 246, 246), // Button background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35), // Match with outer border
                          ),
                      )),
                    ),
                  ),
                ),

              SizedBox(height: 8,),
              GestureDetector(
                onTap: ()=> Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: brown1,fontSize: 16,fontWeight: FontWeight.w300),),
                    SizedBox(width: 4,),
                    Text("Login", style: TextStyle(color: brown1,fontSize: 16,fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              SizedBox(height: 420,),
              GestureDetector(
                child: Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("EVENTURA", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,fontFamily: 'vipinorg',foreground: Paint()
                        ..shader = LinearGradient(colors: [
                          Colors.brown,
                          Colors.white,],
                          stops: [0.6, 3.0],
                          //begin: Alignment.centerRight,
                          // end: Alignment.bottomRight,
                        ).createShader(Rect.fromLTWH(0, 0, 300, 70))),
                      ),],

                  ),
                ),
              )],
          ),
        ),
      ),
    );
  }
}
