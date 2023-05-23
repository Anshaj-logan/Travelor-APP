import 'package:flutter/material.dart';

import 'package:one/agent/Aprofile.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api.dart';

class Aedit extends StatefulWidget {
  String _id;
  String login_id;
  Aedit(this._id, this.login_id);
  //const Aedit({Key? key}) : super(key: key);

  @override
  State<Aedit> createState() => _AeditState();
}

class _AeditState extends State<Aedit> {
  bool passwordVisible = false;
  bool passwordVisible1 = false;
  bool _isloading = false;
  String name = "";
  String username = "";
  String email = "";
  String address = "";
  String phonenumber = "";
  late SharedPreferences localStorage;
  late String _id;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
    passwordVisible = true;
    passwordVisible1 = true;
    _viewUser();
  }

  Future<void> _viewUser() async {
    _id = widget.login_id;
    print('Login id ${_id}');
    var res = await Api().getData('/api/agent/view_agent_profile/' + _id);
    var body = json.decode(res.body);
    print('body of datas${body}');
    setState(() {
      name = body['data'][0]['name'];
      username = body['data'][0]['username'];
      email = body['data'][0]['email'];
      address = body['data'][0]['address'];
      phonenumber = body['data'][0]['phonenumber'];

      nameController.text = name;
      usernameController.text = username;
      emailController.text = email;
      addressController.text = address;
      phonenumberController.text = phonenumber;
    });
  }

  _update() async {
    setState(() {
      var _isLoading = true;
    });
    _id = widget._id;
    print('user id ${_id}');

    var data = {
      "name": nameController.text,
      "username": usernameController.text,
      "address": addressController.text,
      "email": emailController.text,
      "phonenumber": phonenumberController.text,
    };

    print(data);

    var res =
        await Api().authData(data, '/api/agent/update_agent_profile/' + _id);
    var body = json.decode(res.body);
    print(res);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Aprofile()));
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
          title: Text("Edit profile"),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Aprofile())),
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
                  const SizedBox(
                    height: 40,
                  ),
                  buildTextField("name", name, nameController),
                  const SizedBox(
                    height: 40,
                  ),
                  buildTextField("username", username, usernameController),
                  const SizedBox(
                    height: 40,
                  ),
                  buildTextField("email", email, emailController),
                  const SizedBox(
                    height: 40,
                  ),
                  buildTextField(
                      "phonenumber", phonenumber, phonenumberController),
                  const SizedBox(
                    height: 40,
                  ),
                  buildTextField("address", address, addressController),
                  const SizedBox(
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
