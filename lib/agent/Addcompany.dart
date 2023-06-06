import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import 'Ahome.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  late SharedPreferences localStrorage;
  late String agent_id;
  // late String _id;
  TextEditingController nameController = TextEditingController();
  TextEditingController establishedController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectId;

  _Addcompany() async {
    localStrorage = await SharedPreferences.getInstance();
    agent_id = (localStrorage.getString('agentId') ?? '');
    print('agent Id ${agent_id}');
    // String U_id = "${widget._id}";
    // print('U-id ${U_id}');

    var data = {
      "agent_id": agent_id.replaceAll('"', ''),
      "companyname": nameController.text,
      "cityname": selectId,
      "description": discriptionController.text,
      "address": addressController.text,
      "phone": phoneController.text,
    };

    print(data);

    var res = await Api().authData(data, '/api/company/add_comapany');
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('Add Company'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              //.push(MaterialPageRoute(builder: (context) => const Ahome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Company Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: nameController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name of Company'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  DropdownButton<String>(
                    value: selectId,
                    hint: Text('Select city'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectId = newValue;
                      });
                    },
                    items: <String>[
                      'Banglore',
                      'Kochi',
                      'Trivandrum',
                      'Chennai',
                      'Mumbai'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: establishedController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Established Year'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: discriptionController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Description'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: addressController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Address'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: phoneController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone number'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            onPressed: () {
              setState(() {
                _Addcompany();
              });
            },
            child: const Text('Submit'),
          ),
        ),
      ),
    );
  }
}
