import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/views/homepage.dart';
import 'package:eventurapp/views/signup.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../containers/custom_input_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 1),
                child: Text("LOGIN",style: TextStyle(color: Color.fromARGB(
                    255, 103, 98, 85), fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 2,),
              Container(

                child: CustomInputForm(
                  controller: _emailController,
                  icon: Icons.email_outlined, label: "Email", hint: "Enter your email",),
              ),
              SizedBox(height: 1,),
              CustomInputForm(
                obscureText: true,
                controller: _passwordController,
                icon: Icons.lock_outline_rounded, label: "Password", hint: "Enter your Password",),
              SizedBox(height: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text("Forgot Password?",style: TextStyle(color: brown1, fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(35), // Same radius as button
                    ),
                    padding: EdgeInsets.all(3),  // Border thickness
                    child: ElevatedButton(
                      onPressed: () {
                        loginUser(_emailController.text, _passwordController.text).then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
                            Future.delayed(Duration(seconds: 2), () =>
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()))
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to Login")));
                          }
                        });
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(fontWeight: FontWeight.w600,)), /*Paint()
                        ..shader = LinearGradient(colors: [
                                Colors.purple, Colors.pink, Colors.blue],
                                stops: [4, 2, 0.5],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomRight,
                        ).createShader(Rect.fromLTWH(0, 0, 300, 70))),
                      ),*/
                      style: ElevatedButton.styleFrom(
                        foregroundColor: brown1, // Text color
                        elevation: 10,
                        backgroundColor: Color.fromARGB(255, 250, 246, 246), // Button background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35), // Match with outer border
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8,),
              GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New to eventura?", style: TextStyle(color: brown1,fontSize: 16,fontWeight: FontWeight.w300),),
                    SizedBox(width: 4,),
                    Text("Create an account", style: TextStyle(color: brown1,fontSize: 16,fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              // SizedBox(height: 25,),
              // GestureDetector(
              //   onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage())),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text("Bypass Login", style: TextStyle(color: brown1,fontSize: 16,fontWeight: FontWeight.w500,)),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 420,),
              // GestureDetector(
              //   child: Container(
              //
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text("EVENTURA", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,fontFamily: 'vipinorg',foreground: Paint()
              //           ..shader = LinearGradient(colors: [
              //                   Colors.brown,
              //                   Colors.white,],
              //                   stops: [0.6, 3.0],
              //                  //begin: Alignment.centerRight,
              //                  // end: Alignment.bottomRight,
              //           ).createShader(Rect.fromLTWH(0, 0, 300, 70))),
              //         ),],
              //
              //     ),
              //   ),
              // )

            ],
          ),
        ),
      ),
    );
  }
}
