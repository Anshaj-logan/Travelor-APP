import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import 'Companybooking.dart';

class CompanyDetails extends StatefulWidget {
  String companyid;
  CompanyDetails(this.companyid);

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  String companyname = "";
  String address = "";
  String cityname = "";
  String discription = "";
  String phone = "";

  String id = "";
  late String U_id;
  List _loaduserdata = [];
  TextEditingController textController = TextEditingController();
  String displayText = "";
  final List imagesList = [
    "images/cmp1.webp",
    'images/company1.jpg',
    "images/cmp2.jpg",
    'images/company2.jpg',
    "images/cmp2.jpg",
    'images/company3.webp',
  ];
  // final List titles = ["city1", "city2", "city3", "city4", "city5", "city6"];
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
    // _fetchDel();
  }

  _fetchData() async {
    U_id = widget.companyid;

    var res = await Api().getData(
        '/api/company/view_single_company/' + U_id.replaceAll('"', ''));
    print(res);

    if (res.statusCode == 200) {
      var items = json.decode(res.body);
      print('data${items}');

      setState(() {
        companyname = items['data'][0]['companyname'];
        cityname = items['data'][0]['cityname'];
        address = items['data'][0]['address'];
        discription = items['data'][0]['description'];
        phone = items['data'][0]['phone'];

        id = items['data'][0]['_id'];

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
                                // Center(
                                //   child: Text(
                                //     '${titles[_currentIndex]}',
                                //     style: TextStyle(
                                //       fontSize: 24.0,
                                //       fontWeight: FontWeight.bold,
                                //       backgroundColor: Colors.black45,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
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
                      'Company Name :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      companyname,
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Description :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      discription.toString(),
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
                      'Contact Number :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      phone,
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
                      'Address',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //],
                    //),
                    Text(
                      address.toString(),
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
              //         'Budget :',
              //         style:
              //             TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       //],
              //       //),
              //       Text(
              //         budget,
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
              //   child: Row(
              //     children: [
              //       Text(
              //         'Travel Type :',
              //         style:
              //             TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       //],
              //       //),
              //       Text(
              //         traveltype,
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
              //   child: Row(
              //     children: [
              //       Text(
              //         'Activity :',
              //         style:
              //             TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       //],
              //       //),
              //       Text(
              //         activity.toString(),
              //         style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.normal,
              //         ),
              //       ),
              //     ],
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
                MaterialPageRoute(builder: (context) => CompanyBooking(U_id)));
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
