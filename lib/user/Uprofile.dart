import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one/user/Uhome.dart';
import 'package:one/user/Utype.dart';
import 'package:one/user/Uedit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class Uprofile extends StatefulWidget {
  const Uprofile({Key? key}) : super(key: key);

  @override
  State<Uprofile> createState() => _UprofileState();
}

class _UprofileState extends State<Uprofile> {
  late SharedPreferences localStorage;
  String name = "";
  String phonenumber = "";
  String email = "";
  String username = "";
  late String login_id;
  late String _id;
  List _loaduserdata = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    localStorage = await SharedPreferences.getInstance();
    login_id = (localStorage.getString('loginId') ?? '');
    print('Login id ${login_id}');
    var res = await Api().getData(
        '/api/register/view_user_profile/' + login_id.replaceAll('"', ''));
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
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('My Account'),
              backgroundColor: Color(0xff00ADB5),
              leading: IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Uhome())),
                  icon: Icon(Icons.arrow_back)),
              actions: [
                IconButton(
                    onPressed: () async {
                      login_id = _loaduserdata[0]['login_id'];
                      _id = _loaduserdata[0]['_id'];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Uedit(_id, login_id)));
                    },
                    icon: Icon(Icons.edit),
                    tooltip: "Edit Profile"),
              ],
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: _loaduserdata.length,
                itemBuilder: (BuildContext context, int position) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/pro.png"),
                          radius: 60,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Container(
                          width: 320,
                          height: 500,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Name :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _loaduserdata[position]["name"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Email :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _loaduserdata[position]["email"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Phone number :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _loaduserdata[position]["phonenumber"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   children: [
                              //     Text('Username :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              //     SizedBox(width: 20,),
                              //     Text(
                              //       _loaduserdata[position]["username"],
                              //       style: TextStyle(
                              //         fontSize: 20,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ));
  }
}
