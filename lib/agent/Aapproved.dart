import 'package:flutter/material.dart';
import 'package:one/agent/Aapprovedetail.dart';
import 'package:one/agent/Ahome.dart';

class Aapproved extends StatefulWidget {
  const Aapproved({Key? key}) : super(key: key);

  @override
  State<Aapproved> createState() => _AapprovedState();
}

class _AapprovedState extends State<Aapproved> {
  List imagesList = ["images/city6.jpg"];
  List titles = ["package6"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('Approved packages'),
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
                          builder: (BuildContext context) =>
                              const Aapprovedetail()));
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
