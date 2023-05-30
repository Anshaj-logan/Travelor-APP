import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Uhistory.dart';
import 'package:one/user/Uhome.dart';
import 'package:one/user/Utype.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class Utrip extends StatefulWidget {
  const Utrip({Key? key}) : super(key: key);

  @override
  State<Utrip> createState() => _UtripState();
}

class _UtripState extends State<Utrip> {
  List imagesList = [
    "images/city1.jpg",
    "images/city2.jpg",
  ];
  List titles = [
    "Package1",
    "package2",
  ];

  late SharedPreferences localStrorage;
  late String login_id;
  List _loadacceptdata = [];
  late String U_id;
  @override
  void initState() {
    super.initState();

    _acceptData();
  }

  _acceptData() async {
    localStrorage = await SharedPreferences.getInstance();
    login_id = (localStrorage.getString('loginId') ?? '');
    print('login_id ${login_id}');

    var res = await Api().getData(
        '/api/userplan/view-accepted-package/' + login_id.replaceAll('"', ''));
    print(res);

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print('accept data${items}');

      setState(() {
        _loadacceptdata = items;
      });
    } else {
      setState(() {
        _loadacceptdata = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Trips'),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Uhome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            itemCount: _loadacceptdata.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () async {
                      U_id = _loadacceptdata[index]['_id'];
                      print("U_id ${U_id}");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Uhistory(U_id)));
                    },
                    title: Text(_loadacceptdata[index]['package_name']),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("images/city1.jpg"),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
