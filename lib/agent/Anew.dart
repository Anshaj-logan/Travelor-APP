import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/agent/Apack.dart';
import 'package:one/widgets/list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class Anew extends StatefulWidget {
  const Anew({Key? key}) : super(key: key);

  @override
  State<Anew> createState() => _AnewState();
}

class _AnewState extends State<Anew> {
  late SharedPreferences localStrorage;
  late String agentId;
  late String U_id;
  List _loaduserdata = [];
  List imagesList = ["images/city6.jpg"];
  List titles = ["package"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
    // _fetchDel();
  }

  _fetchData() async {
    localStrorage = await SharedPreferences.getInstance();
    agentId = (localStrorage.getString('agentId') ?? '');
    print('agentId ${agentId}');

    var res = await Api().getData('/api/userplan/view-userplan-single-agent/' +
        agentId.replaceAll('"', ''));
    print(res);

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print('profile data${items}');

      setState(() {
        _loaduserdata = items;
      });
    } else {
      setState(() {
        _loaduserdata = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('New packages'),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Ahome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.separated(
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () async {
                  U_id = _loaduserdata[index]['_id'];
                  print("U_id ${U_id}");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Apack(U_id)));
                },
                child: Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("images/city6.jpg"),
                      ),
                      title: Text(
                        _loaduserdata[index]['name'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      trailing: Text(
                        _loaduserdata[index]['traveltype'],
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      )),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: _loaduserdata.length),
        // ListView.builder(
        //     itemCount: _loaduserdata.length,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
        //         child: Card(
        //           child: ListTile(
        //             onTap: () {
        //               Navigator.of(context).pushReplacement(MaterialPageRoute(
        //                   builder: (BuildContext context) => const Apack()));
        //             },
        //             title: Text(_loaduserdata[index]['name']),
        //             leading: CircleAvatar(
        //               backgroundImage: AssetImage(imagesList[index]),
        //             ),
        //           ),
        //         ),
        //       );
        //     }),
      ),
    );
  }
}
