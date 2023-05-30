import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one/agent/Aapprovedetail.dart';
import 'package:one/agent/Ahome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class Aapproved extends StatefulWidget {
  const Aapproved({Key? key}) : super(key: key);

  @override
  State<Aapproved> createState() => _AapprovedState();
}

class _AapprovedState extends State<Aapproved> {
  List imagesList = ["images/city6.jpg"];
  List titles = ["package6"];

  late SharedPreferences localStrorage;
  late String agent_id;
  List _loadacceptdata = [];
  late String U_id;
  @override
  void initState() {
    super.initState();

    _acceptData();
  }

  _acceptData() async {
    localStrorage = await SharedPreferences.getInstance();
    agent_id = (localStrorage.getString('agentId') ?? '');
    print('agent_id ${agent_id}');

    var res = await Api().getData('/api/userplan/view-accepted-package-agent/' +
        agent_id.replaceAll('"', ''));
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
          backgroundColor: Color(0xff00ADB5),
          title: Text('Approved packages'),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Ahome())),
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
                          builder: (BuildContext context) =>
                              Aapprovedetail(U_id)));
                    },
                    title: Text(
                      _loadacceptdata[index]['package_name'],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('images/city6.jpg'),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
