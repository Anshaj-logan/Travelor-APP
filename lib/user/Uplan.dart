import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/user/Uhome.dart';
import 'package:one/user/Utype.dart';
import 'package:one/user/Udate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class Uplan extends StatefulWidget {
  const Uplan({Key? key}) : super(key: key);

  @override
  State<Uplan> createState() => _UplanState();
}

class _UplanState extends State<Uplan> {

  List location = [];
  String? selectId;
  String? selectId1;

  Future getAllId() async {
    var res = await Api().getData('/api/userplan/view_userplan_location');
    var body = json.decode(res.body);
    print(res);
    setState(() {
      print(body);
      location = body['data'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllId();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text("Start planning"),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Uhome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/download.png"),
                    radius: 75,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Text(
                        "From",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(

                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0, style: BorderStyle.solid),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                          hint: Text('From location'),
                          value: selectId,
                          items: location
                              .map((type) => DropdownMenuItem<String>(

                                    value: type['_id'].toString(),
                                    child: Text(type['location'].toString()),
                                  ))
                              .toList(),
                          onChanged: (type) {
                            setState(() {
                              selectId=type;
                            });
                          }),
                      SizedBox(height: 20),
                      Text(
                        "To",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0, style: BorderStyle.solid),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                          hint: Text('Where you want to go?'),
                          value: selectId1,
                          items: location
                              .map((type) => DropdownMenuItem<String>(
                            value: type['_id'].toString(),
                            child: Text(type['location'].toString()),
                                  ))
                              .toList(),
                          onChanged: (type) {
                            setState(() {
                              selectId1=type;
                            });
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextButton.icon(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Uhome())),
                                  label: Text('Back',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextButton.icon(
                                  onPressed: ()  =>

                                     Navigator.push(
                                        context,
                                      MaterialPageRoute(
                                            builder: (context) =>
                                              Udate())),



                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                   ),
                                  label: Text('Next',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
