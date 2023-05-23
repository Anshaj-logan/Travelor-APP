import 'package:flutter/material.dart';
import 'package:one/HomePage.dart';
import 'package:one/ULogin.dart';
import 'package:one/user/USignup.dart';
import 'package:one/user/Umsg.dart';
import 'package:one/user/Utype.dart';
import 'package:one/agent/Aadd.dart';
import 'package:one/user/Uchat.dart';
import 'package:one/widgets/filter.dart';
import 'package:one/user/Uprofile.dart';
import 'package:one/user/Uplan.dart';
import 'package:one/user/Ucity.dart';
import 'package:one/Uwelcome_screen.dart';
import 'package:one/user/Upackages.dart';
import 'package:one/user/Udate.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Uedit.dart';
import 'package:one/widgets/camera.dart';
import 'package:one/user/Uothers.dart';
import 'package:one/user/Ubooking.dart';
import 'package:one/user/Usubmit.dart';
import 'package:one/user/Utrip.dart';
import 'package:one/user/Uapproved.dart';
import 'package:one/agent/Apackages.dart';
import 'package:one/agent/Adetail.dart';
import 'package:one/user/Uhistory.dart';
import 'package:one/agent/Anoti.dart';
import 'package:one/agent/Apack.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/agent/Anew.dart';
import 'package:one/agent/Aapproved.dart';
import 'package:one/agent/Aapprovedetail.dart';

import 'package:one/agent/Aedit.dart';
import 'package:one/agent/Apackageview.dart';
import 'package:one/agent/Asignup.dart';
import 'package:one/agent/Aprofile.dart';
import 'package:one/agent/Atrip.dart';
import 'package:one/agent/Achat.dart';
import 'package:one/agent/Ahistory.dart';
import 'package:one/user/Uhome.dart';
import 'package:one/agent/Alocation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
    debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: UWelcomeScreen(),
    );
  }
}
