import 'dart:convert';

import 'package:flutter/material.dart';

import '../api.dart';
import 'companydetails.dart';

class CompanyView extends StatefulWidget {
  String name;
  CompanyView(this.name);

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  List images = [
    "images/cmp1.webp",
    "images/cmp2.jpg",
    "images/cmp1.webp",
    "images/cmp2.jpg",
    "images/cmp1.webp",
    "images/cmp2.jpg",
    "images/cmp1.webp",
    "images/cmp2.jpg",
    "images/cmp1.webp",
    "images/cmp2.jpg",
  ];

  List loadeddata = [];
  String tripid = '';
  _fetchData() async {
    // String id = widget.index;
    String name = widget.name;
    var res = await Api().getData('/api/company/view_company/' + name);

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        loadeddata = items;
      });
    } else {
      setState(() {
        loadeddata = [];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Choose Company'),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: loadeddata.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  tripid = loadeddata[index]['_id'];
                  print('Package Id ${tripid}');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompanyDetails(tripid)));
                },
                child: GridTile(
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    leading: Text(
                      loadeddata[index]['companyname'],
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
