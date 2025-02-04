import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/views/homepage.dart';
import 'package:eventurapp/views/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            Text("Login",style: TextStyle(color: kLightGreen, fontSize: 32, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 8,),
            CustomInputForm(
              controller: _emailController,
              icon: Icons.email_outlined, label: "Email", hint: "Enter your email",),
            SizedBox(height: 8,),
            CustomInputForm(
              obscureText: true,
              controller: _passwordController,
              icon: Icons.lock_outline_rounded, label: "Password", hint: "Enter your Password",),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Forgot Password",style: TextStyle(color: kLightGreen, fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(height: 8,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(onPressed: (){
                loginUser(_emailController.text, _passwordController.text).then((value){
                  if(value){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
                    Future.delayed(Duration(seconds: 2),()=>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()))
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to Login")));
                  }
                });

              },
                child: Text("Login"),
              style: OutlinedButton.styleFrom(foregroundColor: kLightGreen, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),)),
              ),
            ),
            SizedBox(height: 8,),
            GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create a new account?", style: TextStyle(color: kLightGreen,fontSize: 16,fontWeight: FontWeight.w300),),
                  SizedBox(width: 4,),
                  Text("Sign Up", style: TextStyle(color: kLightGreen,fontSize: 16,fontWeight: FontWeight.w600))
                ],
              ),
            ),
            SizedBox(height: 25,),
            GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bypass Login", style: TextStyle(color: kLightGreen,fontSize: 16,fontWeight: FontWeight.w600,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
