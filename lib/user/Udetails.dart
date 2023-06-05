import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:one/user/Upackages.dart';
import 'package:one/user/Ubooking.dart';
import 'package:one/user/Uchat.dart';

import '../api.dart';

class Udetails extends StatefulWidget {
  String U_id;
  Udetails(this.U_id);
  @override
  State<Udetails> createState() => _UdetailsState();
}

class _UdetailsState extends State<Udetails> {
  String packagename = "";
  String budget = "";
  String cityname = "";
  String distence = "";
  String whether = "";

  // String fromloc = "";
  // String whereloc = "";
  String days = "";

  String traveltype = "";
  String activity = "";
  String requirement = "";
  String id = "";
  late String U_id;
  List _loaduserdata = [];
  TextEditingController textController = TextEditingController();
  String displayText = "";
  final List imagesList = [
    "images/city1.jpg",
    "images/city2.jpg",
    "images/city3.jpg",
    "images/city4.jpg",
    "images/city5.jpg",
    "images/city6.jpg"
  ];
  final List titles = ["city1", "city2", "city3", "city4", "city5", "city6"];
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
    // _fetchDel();
  }

  _fetchData() async {
    U_id = widget.U_id;

    var res = await Api().getData(
        '/api/agent/view_agent_SingleAddPackage/' + U_id.replaceAll('"', ''));
    print(res);

    if (res.statusCode == 200) {
      var items = json.decode(res.body);
      print('data${items}');

      setState(() {
        packagename = items['data'][0]['package_name'];
        cityname = items['data'][0]['cityname'];
        whether = items['data'][0]['weather'];
        budget = items['data'][0]['budget'];
        days = items['data'][0]['days'];
        distence = items['data'][0]['distance'];

        traveltype = items['data'][0]['categoryname'];
        activity = items['data'][0]['activity'];

        id = items['data']['_id'];

        // capacity = body['data'][0]['capacity'];
        // amount = body['data'][0]['amount'];
      });
    }
    // else {
    //   setState(() {
    //     _loaduserdata = [];
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('Package1'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  // enlargeCenterPage: true,
                  //scrollDirection: Axis.vertical,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                items: imagesList
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          elevation: 6.0,
                          shadowColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Center(
                                  child: Text(
                                    '${titles[_currentIndex]}',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.black45,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagesList.map((urlOfItem) {
                  int index = imagesList.indexOf(urlOfItem);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color.fromRGBO(0, 0, 0, 0.8)
                          : Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Details",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Package Name :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      packagename.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'location :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      cityname.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Row(
              //     children: [
              //       Text(
              //         'To Location :',
              //         style:
              //             TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       //],
              //       //),
              //       Text(
              //         whereloc,
              //         style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.normal,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Whether :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      '${whether} °C'.toString(),
                      // whether.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Distence :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      distence.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Days:',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      days.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Budget :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      budget,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Travel Type :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      traveltype,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Activity :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      activity.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Requirements :',
              //         style:
              //             TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       //],
              //       //),
              //       Text(
              //         requirement,
              //         style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.normal,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextField(
              //     //controller: textController,
              //     maxLines: null,
              //     decoration: InputDecoration(
              //       hintText: 'Budget',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextField(
              //     //controller: textController,
              //     maxLines: null,
              //     decoration: InputDecoration(
              //       hintText: 'Distance',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextField(
              //     //controller: textController,
              //     maxLines: null,
              //     decoration: InputDecoration(
              //       hintText: 'Weather details',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 100.0),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         primary: Color(0xff00ADB5),
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(15))),
              //     onPressed: () {
              //       // Navigator.push(context,
              //       //   MaterialPageRoute(builder: (context) => Ubooking()));
              //     },
              //     child: const Text('Book Now'),
              //   ),
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            U_id = id;
            print("U_id ${U_id}");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Ubooking(U_id)));
          },
          label: const Text('Book Now'),
          icon: const Icon(Icons.thumb_up),
          backgroundColor: Colors.pink,
        ),
        // floatingActionButton: IconButton(
        //   onPressed: () => Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (context) => Uchat())),
        //   icon: Icon(
        //     Icons.message,
        //     color: Colors.cyan,
        //   ),
        // ),
      ),
    );
  }
}
