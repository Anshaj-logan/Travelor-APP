import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one/user/Uapproved.dart';
import 'package:one/user/Ubooking.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Uhistory.dart';
import 'package:one/user/Utype.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api.dart';
import 'Uhome.dart';

class Umsg extends StatefulWidget {
  const Umsg({Key? key}) : super(key: key);

  @override
  State<Umsg> createState() => _UmsgState();
}

class _UmsgState extends State<Umsg> with SingleTickerProviderStateMixin {
  List imagesList = ["images/city6.jpg"];
  List titles = ["package6"];

  late TabController tabController;
  late SharedPreferences localStrorage;
  late String login_id;
  List _loadrejectdata = [];
  List _loadacceptdata = [];
  late String U_id;

  @override
  void initState() {
    super.initState();
    _rejectData();
    _acceptData();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  _rejectData() async {
    localStrorage = await SharedPreferences.getInstance();
    login_id = (localStrorage.getString('loginId') ?? '');
    print('login_id ${login_id}');

    var res = await Api().getData(
        '/api/userplan/view-rejected-package/' + login_id.replaceAll('"', ''));
    print(res);

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print('reject data${items}');

      setState(() {
        _loadrejectdata = items;
      });
    } else {
      setState(() {
        _loadrejectdata = [];
      });
    }
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
          backgroundColor: Color(0xff00ADB5),
          title: Text('Notifications'),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Uhome())),
              icon: Icon(Icons.arrow_back)),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: "Accepted packages",
              ),
              Tab(
                text: "Rejected packages",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            ListView.separated(
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () async {
                      U_id = _loadacceptdata[index]['_id'];
                      print("U_id ${U_id}");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Uapproved(U_id)));
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/city6.jpg"),
                        ),
                        title: Text(
                          _loadacceptdata[index]['package_name'],
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        // trailing: Text(
                        //   _loadacceptdata[index]['package_name'],
                        //   style: GoogleFonts.montserrat(
                        //       fontWeight: FontWeight.w600, fontSize: 15),
                        // )
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: _loadacceptdata.length),
            // ListView.builder(
            //     itemCount: _loadacceptdata.length,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(
            //             vertical: 1.0, horizontal: 4.0),
            //         child: Card(
            //           child: ListTile(
            //             onTap: () {
            //               Navigator.of(context).pushReplacement(
            //                   MaterialPageRoute(
            //                       builder: (BuildContext context) =>
            //                           const Uapproved()));
            //             },
            //             title: Text(_loadacceptdata[index]['package_name']),
            //             // leading: CircleAvatar(
            //             //   backgroundImage: AssetImage(imagesList[index]),
            //             // ),
            //           ),
            //         ),
            //       );
            //     }),
            ListView.separated(
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () async {
                      // U_id = _loaduserdata[index]['_id'];
                      // print("U_id ${U_id}");
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Apack(U_id)));
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/city6.jpg"),
                        ),
                        title: Text(
                          _loadrejectdata[index]['package_name'],
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        // trailing: Text(
                        //   _loadacceptdata[index]['package_name'],
                        //   style: GoogleFonts.montserrat(
                        //       fontWeight: FontWeight.w600, fontSize: 15),
                        // )
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: _loadrejectdata.length),
            // ListView.builder(
            //     itemCount: imagesList.length,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(
            //             vertical: 1.0, horizontal: 4.0),
            //         child: Card(
            //           child: ListTile(
            //             onTap: () {
            //               Navigator.of(context).pushReplacement(
            //                   MaterialPageRoute(
            //                       builder: (BuildContext context) =>
            //                           const Uhistory()));
            //             },
            //             title: Text(titles[index]),
            //             leading: CircleAvatar(
            //               backgroundImage: AssetImage(imagesList[index]),
            //             ),
            //           ),
            //         ),
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
}
