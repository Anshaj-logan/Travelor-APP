import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one/user/Ucity.dart';
class camera extends StatelessWidget {
  const camera({Key? key}) : super(key: key);

  void _handleURLButtonPress(BuildContext context, var type) {
    /*Navigator.push(context,
        MaterialPageRoute(builder: (context) => Ucity()));
  */}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image Picker Example"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  "Pick Image from Gallery",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _handleURLButtonPress(context, ImageSource.gallery);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  "Pick Image from Camera",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _handleURLButtonPress(context, ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
  }


