import 'package:flutter/material.dart';
import 'package:one/agent/Aadd.dart';
import 'package:one/agent/Aapproved.dart';
import 'package:one/agent/Acategory.dart';
import 'package:one/agent/Alocation.dart';

import 'package:one/agent/Anew.dart';
import 'package:one/agent/Anoti.dart';
import 'package:one/agent/Apackages.dart';
import 'package:one/agent/Aprofile.dart';
import 'package:one/agent/Atrip.dart';
import 'package:one/ULogin.dart';

import 'Addcompany.dart';

class Ahome extends StatefulWidget {
  const Ahome({Key? key}) : super(key: key);

  @override
  State<Ahome> createState() => _AhomeState();
}

class _AhomeState extends State<Ahome> {
  String tripid = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff00ADB5),
            title: const Text('Home Page'),
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Anoti())),
                  icon: Icon(Icons.notifications)),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff00ADB5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/icon.jpg'),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        'Travel Light',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_box,
                  ),
                  title: const Text('My Account'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Aprofile()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.travel_explore,
                  ),
                  title: const Text('My trip'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Atrip()));
                  },
                ),
                /*ListTile(
                  leading: Icon(
                    Icons.notifications,
                  ),
                  title: const Text('Notifications'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Anoti()));
                  },
                ),*/
                ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: const Text('Log out'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => ULogin()));
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                              color: Color(0xff00ADB5),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 8,
                    shrinkWrap: true,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Acategory()));
                        },
                        child: Container(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'images/solo.jpeg',
                                  height: 120,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Add Category',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Alocation()));
                        },
                        child: Container(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'images/frnds.jpg',
                                  height: 120,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Add Location',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Aadd(
                                        index: '',
                                      )));
                        },
                        child: Container(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/family.jpeg',
                                  height: 120,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Add Packages',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Apackages()));
                        },
                        child: Container(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'images/friends.jpeg',
                                  height: 120,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Packages',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Anew()));
                        },
                        child: Container(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/weekend.jpeg',
                                  height: 120,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Users Packages',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Aapproved()));
                        },
                        child: Container(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/honeymoon.jpeg',
                                  height: 120,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Approved Packages',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCompany()));
                        },
                        child: Container(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/company.webp',
                                  height: 120,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Add Company',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
