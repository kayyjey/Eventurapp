import 'package:eventurapp/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomInputForm extends StatelessWidget {
  final TextEditingController? controller;
  final IconData icon;
  final String label;
  final String hint;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool? readOnly;
  const CustomInputForm(
      {super.key,
        required this.icon,
        required this.label,
        required this.hint,
        this.obscureText,
        this.keyboardType,
        this.maxLines,
        this.onTap,
        this.readOnly,
        this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 5.0),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly ?? false,
            onTap: onTap,
            style: const TextStyle(color: oat1, fontWeight: FontWeight.w900),
            maxLines: maxLines ?? 1,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType ?? TextInputType.text,
            cursorColor: Color.fromARGB(255, 253, 223, 189),
            decoration: InputDecoration(


              filled: true,
              fillColor: const Color.fromARGB(255, 1, 1, 1),//change color here
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),

              labelText: label,
              labelStyle: const TextStyle(
                color: Color.fromARGB(232, 237, 237, 233),
                fontWeight: FontWeight.w600,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 237, 237, 233),
              ),
              prefixIcon: Icon(
                icon,
                color: Color.fromARGB(163, 237, 237, 233),
                size: 20,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
      );

  }
}