import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one/ULogin.dart';
import 'package:one/user/Uhome.dart';
import 'package:one/user/Uivtype.dart';
import 'package:one/user/Umsg.dart';
import 'package:one/user/Uprofile.dart';
import 'package:one/user/Uplan.dart';
import 'package:one/user/Ucity.dart';
import 'package:one/user/Utrip.dart';

import '../api.dart';

class Utype extends StatefulWidget {
  const Utype({Key? key}) : super(key: key);

  @override
  State<Utype> createState() => _UtypeState();
}

class _UtypeState extends State<Utype> {
  /* List items = [
    "Solo",
    "Family",
    "Friends",
    "Honeymoon",
    "Weekend",
    "Industrial Visit"
  ];*/
  List images = [
    "images/sooloc.jpeg",
    "images/familyc.jpeg",
    "images/friendc.jpeg",
    "images/honeymoonc.jpeg",
    "images/weekendc.jpeg",
    "images/ivc.jpeg"
  ];


  List loadeddata = [];
  String tripid='';
  _fetchData() async {
    var res = await Api().getData('/api/category/view_agent_category');

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];

      setState(() {
        loadeddata = items;
        print(loadeddata);
      });
    } else {
      setState(() {
        loadeddata = [];
      });
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select type of travel'),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
                  //.push(MaterialPageRoute(builder: (context) => const Uhome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: loadeddata.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  String categname=loadeddata[index]['categoryname'];

                  tripid=loadeddata[index]['_id'];
                  if(loadeddata[index]['categoryname']=="Industrial Visit"){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Uivtype()));
                  }else {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Ucity(index:tripid,categname:categname)));
                  }
                },
                child: GridTile(
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    leading: Text(
                      loadeddata[index]['categoryname'],
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
