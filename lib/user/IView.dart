import 'dart:convert';

import 'package:flutter/material.dart';

import '../api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Uhome.dart';

class Iview extends StatefulWidget {
  const Iview({Key? key}) : super(key: key);

  @override
  State<Iview> createState() => _IviewState();
}

class _IviewState extends State<Iview> {
  List imagesList = [
    'images/company1.jpg',
    'images/company2.jpg',
    'images/company3.webp',
    'images/company4.jpg',
    'images/company5.jpg',
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
  late SharedPreferences localStrorage;
  late String user_id;

  /*late String packagename_id;
  late String _id;*/
  fetch() async {
    localStrorage = await SharedPreferences.getInstance();
    user_id = (localStrorage.getString('user_id') ?? '');

    var res = await Api().getData(
        '/api/company/view-iv-user-booking/' + user_id.replaceAll('"', ''));
    print(res);

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print('booking data${items}');

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
    super.initState();
    fetch();
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
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Uhome())),
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
                      // tripid = loadeddata[index]['_id'];
                      // print(tripid);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => Adetail(tripid: tripid)));
                    },
                    child: ListTile(
                      /*onTap: () async{
                        tripid = loadeddata[index]['_id'];
                        print(tripid);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Adetail(tripid)));
                      },*/
                      title: Text(loadeddata[index]['company_name'].toString()),
                      subtitle: Column(
                        children: [
                          Text(loadeddata[index]['cityname'].toString()),
                          Text(loadeddata[index]['phone'].toString()),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text('Booking Date'),
                          Text(loadeddata[index]['date'].toString()),
                        ],
                      ),
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
