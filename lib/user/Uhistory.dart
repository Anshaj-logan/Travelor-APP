import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:one/user/Upackages.dart';
import 'package:one/user/Ubooking.dart';
import 'package:one/user/Uchat.dart';
import 'package:one/user/Utrip.dart';
//import 'package:one/screens/filter.dart';

class Uhistory extends StatefulWidget {
  const Uhistory({Key? key}) : super(key: key);

  @override
  State<Uhistory> createState() => _UhistoryState();
}

class _UhistoryState extends State<Uhistory> {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor:Color(0xff00ADB5),
          title: Text('Package1'),
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Utrip())),

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
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(controller: textController,maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(controller: textController,maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(controller: textController,maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                  ),
                ),
              ),



            ],
          ),
        ),

      ),
    );
  }
}
