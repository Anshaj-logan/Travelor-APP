import 'package:flutter/material.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Udetails.dart';

class Uchat extends StatefulWidget {
  const Uchat({Key? key}) : super(key: key);

  @override
  State<Uchat> createState() => _UchatState();
}

class _UchatState extends State<Uchat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor:Color(0xff00ADB5),
          title: Text('Package1'),
          leading: IconButton(
              onPressed: ()=>Navigator.pop(context),
             // {Navigator.push(context, MaterialPageRoute(builder: (context)=>Udetails()));},

              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                 Container(
                   padding: EdgeInsets.all(8),
                   margin: EdgeInsets.all(8),
                   child: Text('New message',
                     style: TextStyle(
                       fontSize: 23,
                     ),
                   ),
                   decoration: BoxDecoration(
                     color: Colors.grey[300],
                     borderRadius: BorderRadius.circular(20),
                   ),
                 ),
                ],
              ),

            ),
            Container(
              height: 60,
              color: Colors.grey[100],
              child: Row(
                children: [
                  Expanded(
                child:  TextField(),
    ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
