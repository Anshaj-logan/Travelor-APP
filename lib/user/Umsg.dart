import 'package:flutter/material.dart';
import 'package:one/user/Uapproved.dart';
import 'package:one/user/Ubooking.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Uhistory.dart';
import 'package:one/user/Utype.dart';

class Umsg extends StatefulWidget {
  const Umsg({Key? key}) : super(key: key);

  @override
  State<Umsg> createState() => _UmsgState();
}

class _UmsgState extends State<Umsg> with SingleTickerProviderStateMixin{
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
        appBar: AppBar(backgroundColor:Color(0xff00ADB5),
          title: Text('Notifications'),
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Utype())),

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


                 ListView.builder(
                     itemCount: imagesList.length,
                     itemBuilder: (context,index) {
                       return Padding(
                         padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
                         child: Card(
                           child: ListTile(
                             onTap: () {
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Uapproved()));
                             },
                             title: Text(titles[index]),
                             leading: CircleAvatar(
                               backgroundImage: AssetImage(imagesList[index]),
                             ),

                           ),
                         ),
                       );
                     }
                 ),

                 ListView.builder(
                     itemCount: imagesList.length,
                     itemBuilder: (context,index) {
                       return Padding(
                         padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
                         child: Card(
                           child: ListTile(
                             onTap: () {
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Uhistory()));
                             },
                             title: Text(titles[index]),
                             leading: CircleAvatar(
                               backgroundImage: AssetImage(imagesList[index]),
                             ),

                           ),
                         ),
                       );
                     }
                 ),
               ],
),

      ),

    );
  }
}
