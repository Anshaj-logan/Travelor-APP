import 'package:flutter/material.dart';
import 'package:one/user/Ucity.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Uivcity.dart';
import 'package:one/user/Uivdetail.dart';
class Uiv extends StatefulWidget {
  const Uiv({Key? key}) : super(key: key);

  @override
  State<Uiv> createState() => _UivState();
}

class _UivState extends State<Uiv> {
  List imagesList = [
    "images/city1.jpg",
    "images/city2.jpg",
    "images/city3.jpg",
    "images/city4.jpg",
    "images/city5.jpg",
    "images/city6.jpg"
  ];
  List titles = [
    "Company1",
    "Company2",
    "Company3",
    "Company4",
    "Company5",
    "Company6"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Companies'),
          backgroundColor:Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Uivcity())),

              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            itemCount: imagesList.length,
            itemBuilder: (context,index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Uivdetail()));
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

      ),
    );
  }
}
