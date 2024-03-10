import 'dart:io'; // Import for file operations
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart'; // Import gallery_saver package

class imager extends StatefulWidget {
  const imager({Key? key}) : super(key: key);

  @override
  _imagerState createState() => _imagerState();
}

class _imagerState extends State<imager> {
  File? _selectedImage; // Declare _selectedImage as File?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Text(
          'Learning Image Picking',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _pickImageFromGallery();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: Text(
                'Pick Image from Gallery',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImageFromCamera();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: Text(
                'Pick Image from Camera',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _selectedImage != null
                ? Image.file(_selectedImage!) // Display selected image
                : Text('Please Select Image'), // If no image is selected
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;

    // final Directory appDirectory =
    //     await getExternalStorageDirectory();
    final Directory appDirectory =
        (await getExternalStorageDirectory())!; // Use external storage directory
    final String imagePath = '${appDirectory.path}/image.jpg';

    final File newImage = await File(pickedImage.path).copy(imagePath);
    GallerySaver.saveImage(newImage.path); // Save image to gallery

    setState(() {
      _selectedImage = newImage;
    });
  }
}
