import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/agent/Apack.dart';
import 'package:one/user/Udetails.dart';

import '../api.dart';
import 'Ahome.dart';

class Achat extends StatefulWidget {
  String agent;
  String user;

  Achat(this.agent, this.user);

  @override
  State<Achat> createState() => _AchatState();
}

class _AchatState extends State<Achat> {
  TextEditingController chatController = TextEditingController();
  _boooking() async {
    String agent = "${widget.agent}";
    print('agent ${agent}');
    String user = "${widget.user}";
    print('user ${user}');

    var data = {
      "user_login_id": user.replaceAll('"', ''),
      "agent_id": agent.replaceAll('"', ''),
      "addchat": chatController.text,
    };

    print(data);

    var res = await Api().authData(data, '/api/chat/addchat');
    var body = json.decode(res.body);
    print(res);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => Ahome()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
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
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Ahome()));
              },
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
                    child: Text(
                      'New message',
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
                    child: TextField(
                      controller: chatController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _boooking();
                    },
                    icon: Icon(Icons.send),
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
