import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/user/Udate.dart';

import 'package:one/user/Usubmit.dart';

import '../api.dart';

class Uothers extends StatefulWidget {
  const Uothers({Key? key}) : super(key: key);

  @override
  State<Uothers> createState() => _UothersState();
}

class _UothersState extends State<Uothers> {
  /*List items = [

    "Solo",
    "Family",
    "Friends",
    "Industrial visit",
    "Honeymoon",
    "Weekend"
  ];*/
  List traveltype = [];
  String? selectId;
  bool _isloading = false;
  TextEditingController personsController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();

  Future getcategories() async {
    var res = await Api().getData('/api/category/view_agent_category');
    var body = json.decode(res.body);
    print(res);
    setState(() {
      print(body);
      traveltype = body['data'];
    });
  }

  @override
  void initState() {
    // TODO: iplement initState
    super.initState();
    getcategories();
  }

  final _formKey = GlobalKey<FormState>();
  void UserSelect() async {
    setState(() {
      _isloading = true;
    });
    var data = {
      "persons": personsController.text,
      "budget": budgetController.text,
      "requirements": requirementsController.text,
      "categoryname": selectId,
    };
    var res = await Api().authData(data, '/api/userplan/user-select');
    var body = json.decode(res.body);
    print(body);
    if (body["success"] == true) {
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
      print('res${res}');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Ahome()));
    } else {
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
    }
  }

  List agents = ["A1", "A2", "A3", "A4", "A5", "A6"];
  String? selectedValue1;
  String? selectedValue2;
  List titles = [
    "Waterfall",
    "Hilly Region",
    "Temple",
    "Amusement Parks",
    "Historic Places",
  ];

  bool? isChecked1 = false;
  bool? isChecked2 = false;
  bool? isChecked3 = false;
  bool? isChecked4 = false;
  bool? isChecked5 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('Select Inclusions'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Number of Persons',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: personsController,
                    decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Number of Persons',
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Set Your Budget',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: budgetController,
                    decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Budget'
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select Type of Travel',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.travel_explore),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    hint: Text('Travel Type'),
                    value: selectedValue1,
                    items: traveltype
                        .map((type) => DropdownMenuItem<String>(
                              value: type['categoryname'].toString(),
                              child: Text(type['categoryname'].toString()),
                            ))
                        .toList(),
                    onChanged: (type) {
                      setState(() {
                        selectedValue1 = type;
                      });
                    }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Activities",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text("Waterfall"),
                    activeColor: Colors.blue,
                    value: isChecked1,
                    onChanged: (val) {
                      setState(() {
                        isChecked1 = val;
                      });
                    }),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text("Temple"),
                    activeColor: Colors.blue,
                    value: isChecked2,
                    onChanged: (val) {
                      setState(() {
                        isChecked2 = val;
                      });
                    }),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text("Hilly Region"),
                    activeColor: Colors.blue,
                    value: isChecked3,
                    onChanged: (val) {
                      setState(() {
                        isChecked3 = val;
                      });
                    }),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text("Amusement Parks"),
                    activeColor: Colors.blue,
                    value: isChecked4,
                    onChanged: (val) {
                      setState(() {
                        isChecked4 = val;
                      });
                    }),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text("Historic Places"),
                    activeColor: Colors.blue,
                    value: isChecked5,
                    onChanged: (val) {
                      setState(() {
                        isChecked5 = val;
                      });
                    }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Additional Requirements',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add Requirements',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select Travel Agent ',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                /*DropdownButtonFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.travel_explore),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    hint: Text('Travel Agent'),
                    value: selectedValue2,
                    items: agents
                        .map((type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (type) {
                      setState(() {
                        selectedValue2 = type;
                      });
                    }),*/
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Udate())),
                              child: Text('Back',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black))),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan),
                              onPressed: () {
                                setState(() {
                                  UserSelect();
                                });
                              },
                              /*=> Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Usubmit())),*/
                              child: Text('Submit',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
