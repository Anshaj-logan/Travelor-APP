import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one/user/Utype.dart';
import 'package:one/user/Upackages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api.dart';

class Ucity extends StatefulWidget {
  String index;
  String categname;

  Ucity({required this.index,required this.categname});

  @override
  State<Ucity> createState() => _UcityState();
}

class _UcityState extends State<Ucity> {
  /* List items = [
    "City Name1",
    "City Name2",
    "City Name3",
    "City Name4",
    "City Name5",
    "City Name6",
    "City Name7",
    "City Name8",
    "City Name9",
    "City Name10"
  ];*/
  List images = [
    "images/city1.jpg",
    "images/city2.jpg",
    "images/city3.jpg",
    "images/city4.jpg",
    "images/city5.jpg",
    "images/city6.jpg",
    "images/city1.jpg",
    "images/city2.jpg",
    "images/city3.jpg",
    "images/city4.jpg"
  ];

  List loadeddata = [];
  String tripid = '';
  _fetchData() async {
    String id = widget.index;
    String name=widget.categname;
    var res = await Api().getData('/api/category/view-city/'+name);

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
          title: const Text('Choose Interested Places'),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
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
                  tripid = loadeddata[index]['_id'];
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Upackages(index: tripid,cityname: '',)));
                },
                child: GridTile(
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    leading: Text(
                      loadeddata[index]['cityname'],
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
