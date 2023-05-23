import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/agent/Aadd.dart';
import 'package:one/user/Ucity.dart';
import 'package:one/user/Uchat.dart';

import '../api.dart';

class Upackages extends StatefulWidget {
  String index;
  String cityname;
  Upackages({required this.index,required this.cityname});
 // const Upackages({Key? key}) : super(key: key);

  @override
  State<Upackages> createState() => _UpackagesState();
}

class _UpackagesState extends State<Upackages> {
  List imagesList = [
    "images/city1.jpg",
    "images/city2.jpg",
    "images/city3.jpg",
    "images/city4.jpg",
    "images/city5.jpg",
    "images/city6.jpg"
  ];
 /* List titles = [
    "Package1",
    "package2",
    "package3",
    "package4",
    "package5",
    "package6"
  ];
  List subtitles = [
    "Budget",
    "Budget",
    "Budget",
    "Budget",
    "Budget",
    "Budget",
  ];*/

  List loadeddata = [];
  String tripid='';
  _fetchData() async {
    String id=widget.index;
    String name=widget.cityname;
    var res = await Api().getData('/api/category/view_packages/'+ name);
     print(res);

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        loadeddata = items;
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
          title: const Text('City Name1'),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () =>Navigator.pop(context),
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            itemCount: loadeddata.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      tripid = loadeddata[index]['_id'];
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Udetails()));
                    },
                    title: Text(loadeddata[index]['package_name']),
                    subtitle: Text(loadeddata[index]['budget']),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(imagesList[index]),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
