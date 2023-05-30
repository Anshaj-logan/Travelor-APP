import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:one/user/Ubooking.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Utype.dart';
import 'package:one/agent/Ahome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class Anoti extends StatefulWidget {
  const Anoti({Key? key}) : super(key: key);

  @override
  State<Anoti> createState() => _AnotiState();
}

class _AnotiState extends State<Anoti> with SingleTickerProviderStateMixin {
  List imagesList = ["images/city6.jpg"];
  List titles = ["package6"];

  late TabController tabController;
  late SharedPreferences localStrorage;
  late String agent_id;
  List _loadacceptdata = [];

  _payment() async {
    localStrorage = await SharedPreferences.getInstance();
    agent_id = (localStrorage.getString('agentId') ?? '');
    print('login_id ${agent_id}');

    var res = await Api()
        .getData('/api/userplan/view_payment/' + agent_id.replaceAll('"', ''));
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
  void initState() {
    super.initState();
    _payment();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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
                  .push(MaterialPageRoute(builder: (context) => const Ahome())),
              icon: Icon(Icons.arrow_back)),
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.payment),
                text: "Payment status",
              ),
              Tab(
                icon: Icon(Icons.message),
                text: "Messages",
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
                      // U_id = _loadacceptdata[index]['_id'];
                      // print("U_id ${U_id}");
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => Uapproved(U_id)));
                    },
                    child: Card(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "User name:",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _loadacceptdata[index]['name'],
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Package name:",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _loadacceptdata[index]['package_name'],
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "payment mode:",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _loadacceptdata[index]['mode'],
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "payment date:",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _loadacceptdata[index]['date'],
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )
                          ],
                        )
                      ],
                    )
                        // ListTile(
                        //     leading: Text(
                        //       _loadacceptdata[index]['package_name'],
                        //     ),
                        //     title: Text(
                        //       _loadacceptdata[index]['name'],
                        //       style: GoogleFonts.montserrat(
                        //           fontWeight: FontWeight.w600, fontSize: 20),
                        //     ),
                        //     subtitle: Text(
                        //       _loadacceptdata[index]['mode'],
                        //       style: GoogleFonts.montserrat(
                        //           fontWeight: FontWeight.w600, fontSize: 20),
                        //     ),
                        //     trailing: Text(
                        //       _loadacceptdata[index]['date'],
                        //       style: GoogleFonts.montserrat(
                        //           fontWeight: FontWeight.w600, fontSize: 15),
                        //     )),
                        ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: _loadacceptdata.length),
            Text("Messages")
          ],
        ),
      ),
    );
  }
}
