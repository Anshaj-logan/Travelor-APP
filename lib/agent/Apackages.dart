import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/agent/Apackageview.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/agent/Adetail.dart';

import 'package:one/agent/Aadd.dart';
import 'package:one/user/Ucity.dart';
import 'package:one/user/Uchat.dart';

import '../api.dart';

class Apackages extends StatefulWidget {
  const Apackages({Key? key}) : super(key: key);
  // String index;
  //Apackages({required this.index});

  @override
  State<Apackages> createState() => _ApackagesState();
}

class _ApackagesState extends State<Apackages> {
  List imagesList = [
    "images/city1.jpg",
    "images/city2.jpg",
    "images/city3.jpg",
    "images/city4.jpg",
    "images/city5.jpg",
    "images/city6.jpg",
    "images/city6.jpg"
  ];
  /*List titles = [
    "Package1",
    "package2",
    "package3",
    "package4",
    "package5",
    "package6"
  ];*/

  List loadeddata = [];
  late String tripid = '';

  /*late String packagename_id;
  late String _id;*/
  _fetchData() async {
    // String id=widget.index;
    var res = await Api().getData('/api/agent/view_agent_AddPackage');
    //print(id);
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
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
          title: const Text('Packages'),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: loadeddata.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 4.0),
                  child: Card(
                      child: GestureDetector(
                    onTap: () async {
                      tripid = loadeddata[index]['_id'];
                      print(tripid);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Adetail(tripid: tripid)));
                    },
                    child: ListTile(
                      /*onTap: () async{
                        tripid = loadeddata[index]['_id'];
                        print(tripid);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Adetail(tripid)));
                      },*/
                      title: Text(loadeddata[index]['package_name'].toString()),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(imagesList[index]),
                      ),
                    ),
                  )));
            }),
      ),
    );
  }
}
