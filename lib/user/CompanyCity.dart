import 'package:flutter/material.dart';

import 'companyview.dart';

class CompanyCity extends StatefulWidget {
  const CompanyCity({Key? key}) : super(key: key);

  @override
  State<CompanyCity> createState() => _CompanyCityState();
}

class _CompanyCityState extends State<CompanyCity> {
  List images = [
    'images/company1.jpg',
    'images/company2.jpg',
    'images/company3.webp',
    'images/company4.jpg',
    'images/company5.jpg',
  ];

  List cities = ['Banglore', 'Kochi', 'Trivandrum', 'Chennai', 'Mumbai'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Choose Interested Places'),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  String name = cities[index];

                  print('Cityname ${name}');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompanyView(name)));
                },
                child: GridTile(
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    leading: Text(
                      cities[index],
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
