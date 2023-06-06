import 'package:flutter/material.dart';
import 'package:one/ULogin.dart';
import 'package:one/user/Ucity.dart';
import 'package:one/user/Umsg.dart';
import 'package:one/user/Uplan.dart';
import 'package:one/user/Uprofile.dart';
import 'package:one/user/Usubmit.dart';
import 'package:one/user/Utrip.dart';
import 'package:one/user/Utype.dart';

import 'CompanyCity.dart';

class Uhome extends StatefulWidget {
  const Uhome({Key? key}) : super(key: key);

  @override
  State<Uhome> createState() => _UhomeState();
}

class _UhomeState extends State<Uhome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('Home'),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Umsg())),
                icon: Icon(Icons.notifications)),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xff00ADB5)),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      builder: (BuildContext context) => Uprofile()));
                },
              ),
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
          child: Column(
            children: [
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
              SizedBox(height: 40),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Utype()));
                    },
                    child: Container(
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'images/uhome.jpeg',
                              height: 120,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Travel Types',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Uplan()));
                    },
                    child: Container(
                      child: Card(
                        elevation: 30,
                        child: Column(
                          children: [
                            Image.asset(
                              'images/uhome1.jpg',
                              height: 120,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Plan My Holiday',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyCity()));
                    },
                    child: Container(
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset(
                              'images/IV.jpg',
                              height: 120,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'IV Plans',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                          MaterialPageRoute(builder: (context) => Utrip()));
                    },
                    child: Container(
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset(
                              'images/uhome2.jpg',
                              height: 120,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'My Trips',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )

              /*Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 8,
                    shrinkWrap: true,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Utype()));
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
                                    'Travel Types',
                                    style: TextStyle(
                                        fontSize: 20,
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
                              MaterialPageRoute(builder: (context) => Usubmit()));
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
                                    'Locations',
                                    style: TextStyle(
                                        fontSize: 20,
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
                              MaterialPageRoute(builder: (context) => Uplan()));
                        },
                        child: Container(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
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
                                    'Plan My Holiday',
                                    style: TextStyle(
                                        fontSize: 20,
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
                              MaterialPageRoute(builder: (context) => Utrip()));
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
                                    'My Trips',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
