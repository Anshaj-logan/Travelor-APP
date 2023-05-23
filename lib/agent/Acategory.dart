import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/agent/Apack.dart';
import 'package:one/user/Udetails.dart';

import '../api.dart';

class Acategory extends StatefulWidget {
  const Acategory({Key? key}) : super(key: key);

  @override
  State<Acategory> createState() => _AcategoryState();
}

class _AcategoryState extends State<Acategory> {
  bool _isloading = false;

  TextEditingController categoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void UserCategory() async {
    setState(() {
      _isloading = true;
    });
    var data = {
      "categoryname": categoryController.text,

    };
    var res = await Api().authData(data, '/api/category/agent_category');
    var body = json.decode(res.body);
    print(body);
    if (body["success"] == true) {
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
      print('res${res}');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Ahome()));
    } else {
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('Categories'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              //.push(MaterialPageRoute(builder: (context) => const Ahome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add category',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              style: TextStyle(height: 2),
              controller: categoryController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'category name'),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.cyan),
                onPressed: () {
                  UserCategory();
                },
                child: Text('Add',
                    style: TextStyle(fontSize: 15, color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
