import 'package:flutter/material.dart';
import 'package:one/user/Uhome.dart';
import 'package:one/user/Uplan.dart';
import 'package:one/user/Utype.dart';
import 'package:one/user/Ubooking.dart';
class Usubmit extends StatefulWidget {
  const Usubmit({Key? key}) : super(key: key);

  @override
  State<Usubmit> createState() => _UsubmitState();
}

class _UsubmitState extends State<Usubmit> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
         Scaffold(
          //backgroundColor: Color(0xff00ADB5),
          appBar: AppBar(backgroundColor: Color(0xff00ADB5),
            title: Text('Submitted'),
            leading: IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Uhome())),

                icon: Icon(Icons.arrow_back)),
         ),
          body: Center(
         child: Container(
           width: 100,
            height: 100,
            child: Image.asset('images/submit.jpg'),
          ),
        ),

    ),
    );
  }
}
