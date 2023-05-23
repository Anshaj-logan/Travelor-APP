import 'package:flutter/material.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/agent/Apack.dart';

class Anew extends StatefulWidget {
  const Anew({Key? key}) : super(key: key);

  @override
  State<Anew> createState() => _AnewState();
}

class _AnewState extends State<Anew> {
  List imagesList = ["images/city6.jpg"];
  List titles = ["package6"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('New packages'),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Ahome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            itemCount: imagesList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const Apack()));
                    },
                    title: Text(titles[index]),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(imagesList[index]),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
