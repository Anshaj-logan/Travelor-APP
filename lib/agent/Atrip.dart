import 'package:flutter/material.dart';
import 'package:one/agent/Ahistory.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Uhistory.dart';
import 'package:one/user/Utype.dart';

class Atrip extends StatefulWidget {
  const Atrip({Key? key}) : super(key: key);

  @override
  State<Atrip> createState() => _AtripState();
}

class _AtripState extends State<Atrip> {
  List imagesList = [
    "images/city1.jpg",
    "images/city2.jpg",

  ];
  List titles = [
    "Package1",
    "package2",
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xff00ADB5),
          title: Text('My Trips'),
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Ahome())),

              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            itemCount: imagesList.length,
            itemBuilder: (context,index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Ahistory()));
                    },
                    title: Text(titles[index]),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(imagesList[index]),
                    ),

                  ),
                ),
              );
            }
        ),

      ),
    );
  }
}