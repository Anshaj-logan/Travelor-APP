import 'package:flutter/material.dart';

import 'package:one/user/Ubooking.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Utype.dart';
import 'package:one/agent/Ahome.dart';

class Anoti extends StatefulWidget {
  const Anoti({Key? key}) : super(key: key);

  @override
  State<Anoti> createState() => _AnotiState();
}

class _AnotiState extends State<Anoti> with SingleTickerProviderStateMixin{
  List imagesList = [

    "images/city6.jpg"
  ];
  List titles = [

    "package6"
  ];


  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this,initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xff00ADB5),
          title: Text('Notifications'),
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Ahome())),

              icon: Icon(Icons.arrow_back)),
          bottom: TabBar(indicatorColor: Colors.white,
            controller: tabController,
            tabs: [

              Tab(icon: Icon(Icons.payment),
                text: "Payment status",
              ),
              Tab(icon: Icon(Icons.message),
                text: "Messages",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [



            Text("Payment status",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


            Text("Messages")
          ],
        ),

      ),

    );
  }
}