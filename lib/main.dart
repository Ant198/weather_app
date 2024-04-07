//import 'dart:convert';
import 'package:flutter_application_1/home_page/home_page.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: HomePage(),
    );
  }
}




