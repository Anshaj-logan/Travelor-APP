import 'package:flutter/material.dart';
import 'package:one/agent/Adetail.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api.dart';

class Apackageview extends StatefulWidget {
  String _id;
  //String login_id;
  Apackageview(this._id);
  //const Aedit({Key? key}) : super(key: key);

  @override
  State<Apackageview> createState() => _ApackageviewState();
}

class _ApackageviewState extends State<Apackageview> {
  bool _isloading = false;
  String package_name = "";
  String traveltype = "";
  String cityname = "";
  String description = "";
  String distance = "";
  String days = "";
  String weather = "";
  String budget = "";
  String activity = "";
  late SharedPreferences localStorage;
  late String _id;

  TextEditingController package_nameController = TextEditingController();
  TextEditingController traveltypeController = TextEditingController();
  TextEditingController citynameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController weatherController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController activityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();

    _viewPackage();
  }

  Future<void> _viewPackage() async {
    _id = widget._id;
    print('Packagename id ${_id}');
    var res =
        await Api().getData('/api/agent/view_agent_SingleAddPackage/' + _id);
    var body = json.decode(res.body);
    print('body of datas${body}');
    setState(() {
      package_name = body['data'][0]['package_name'];
      traveltype = body['data'][0]['traveltype'];
      cityname = body['data'][0]['cityname'];
      description = body['data'][0]['description'];
      distance = body['data'][0]['distance'];
      days = body['data'][0]['days'];
      weather = body['data'][0]['weather'];
      budget = body['data'][0]['budget'];
      activity = body['data'][0]['activity'];

      package_nameController.text = package_name;
      traveltypeController.text = traveltype;
      citynameController.text = cityname;
      descriptionController.text = description;
      distanceController.text = distance;
      daysController.text = days;
      weatherController.text = weather;
      budgetController.text = budget;
      activityController.text = activity;
    });
  }

  _update() async {
    setState(() {
      var _isLoading = true;
    });
    _id = widget._id;
    print('packagename_id ${_id}');

    var data = {
      "package_name": package_nameController.text,
      "traveltype": traveltypeController.text,
      "cityname": citynameController.text,
      "description": descriptionController.text,
      "distance": distanceController.text,
      "days": daysController.text,
      "weather": weatherController.text,
      "budget": budgetController.text,
      "activity": activityController.text,
    };

    print(data);

    var res =
        await Api().authData(data, '/api/agent/update_agent_package/' + _id);
    var body = json.decode(res.body);
    print(res);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Adetail(tripid: 'tripid')));
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
          title: Text("Edit package"),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              //.push(MaterialPageRoute(builder: (context) => Adetail())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField(
                      "package_name", package_name, package_nameController),
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField(
                      "traveltype", traveltype, traveltypeController),
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField("cityname", cityname, citynameController),
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField(
                      "description", description, descriptionController),
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField("distance", distance, distanceController),
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField("days", days, daysController),
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField("weather", weather, weatherController),
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField("budget", budget, budgetController),
                   SizedBox(
                    height: 40,
                  ),
                  buildTextField("activity", activity, activityController),
                   SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.cyan),
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _update();
                                });
                              },
                              child: Text(
                                "UPDATE",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labeltext, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labeltext,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
