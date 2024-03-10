//import 'package:filemanager/gallery.dart';
import 'package:filemanager/new.dart';
//import 'package:filemanager/images.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:camera/camera.dart';
//import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: imager(),
    );
  }
}
