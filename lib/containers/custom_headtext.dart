import 'package:eventurapp/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomHeadtext extends StatefulWidget {
  final String text;
  const CustomHeadtext({super.key, required this.text});

  @override
  State<CustomHeadtext> createState() => _CustomHeadtextState();
}

class _CustomHeadtextState extends State<CustomHeadtext> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,style: TextStyle(color: kLightGreen,fontSize: 32,fontWeight: FontWeight.w600));
  }
}
