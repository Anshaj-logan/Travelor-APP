import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/ULogin.dart';
import 'package:one/user/USignup.dart';
import 'package:one/user/Uhome.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class UWelcomeScreen extends StatefulWidget {
  const UWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<UWelcomeScreen> createState() => _UWelcomeScreenState();
}

class _UWelcomeScreenState extends State<UWelcomeScreen> {
  String agent = "1";
  String user = "2";
  late SharedPreferences localstorage;
  String role = "";

  checkRole() async {
    localstorage = await SharedPreferences.getInstance();
    role = (localstorage.getString('role') ?? '');
    if (agent == role.replaceAll('"', '')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Ahome()));
    } else if (user == role.replaceAll('"', '')){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Uhome()));
  }

  else{
  Navigator.pushReplacement(
  context, MaterialPageRoute(builder: (context) => ULogin()));
  }
}
  var height, width;


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Colors.grey.shade200,
              child: Image.asset(
                'images/splash.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: height * 0.32,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Lets start journey, Enjoy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.058,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    Text(
                      'Beautiful moments of life',
                      style: TextStyle(
                          fontSize: width * 0.058,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        checkRole();
                        /*Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ULogin()));*/
                      },
                      child: Container(
                        height: height * 0.065,
                        width: width * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Start",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
