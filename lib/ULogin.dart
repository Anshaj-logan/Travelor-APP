import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/HomePage.dart';
import 'package:one/agent/Ahome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one/user/USignup.dart';
import 'package:one/user/Uhome.dart';

import 'api.dart';

class ULogin extends StatefulWidget {
  const ULogin({Key? key}) : super(key: key);

  @override
  State<ULogin> createState() => _ULoginState();
}

class _ULoginState extends State<ULogin> {
  String agent = "1";
  String user = "2";
  String storedValue = "1";
  late SharedPreferences localstorage;
  String Login_id = "";
  String role = "";
  String status = "";
  bool _isloading = false;
  bool _obscuretext = true;
  bool passwordVisible = false;

  final us = TextEditingController();
  final pwd = TextEditingController();

  _pressloginButton() async {
    setState(() {
      _isloading = true;
    });
    var data = {
      "username": us.text.trim(),
      "password": pwd.text.trim(),
    };
    print(data);
    var res = await Api().authData(data, '/api/login/');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
      print(body);
      role = json.encode(body['role']);
      status = json.encode(body['status']);
      print('user ${user}');
      print('role ${role}');
      print('status ${status}');
      if (agent == role.replaceAll('"', '') &&
          storedValue == status.replaceAll('"', '')) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Ahome()));
      } else if (user == role.replaceAll('"', '') &&
          storedValue == status.replaceAll('"', '')) {
        Navigator.of(context).push(
             MaterialPageRoute(builder: (context) => Uhome()));
      } else {
        Fluttertoast.showToast(
          msg: body['message'].toString(),
          backgroundColor: Colors.grey,
        );
      }

      localstorage = await SharedPreferences.getInstance();
      localstorage.setString('role', role.toString());
      localstorage.setString(
          'loginId', json.encode(body['login_id']).toString());
      localstorage.setString('agentId', json.encode(body['agt_id']).toString());

      String loginId = (localstorage.getString('login_id') ?? '');
      String agentId = (localstorage.getString('agt_id') ?? '');
      print(loginId);
      print(agentId);
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }

    String _password = "";

    @override
    void dispose() {
      us.dispose();
      pwd.dispose();
      super.dispose();
    }

    void _toggle() {
      setState(() {
        _obscuretext = !_obscuretext;
      });
    }

    @override
    void initState() {
      super.initState();
      passwordVisible = true;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'images/login.png',
                        width: size.width,
                        height: size.height * .40,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * .03),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * .05,
                      right: size.width * .05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * .02),
                        TextField(
                          controller: us,
                          decoration: InputDecoration(
                            focusColor: Color(0xff00ADB5),
                            hoverColor: Color(0xff00ADB5),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff00ADB5))),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'Username',
                            prefixIcon:
                                Icon(Icons.account_box, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: size.height * .02),
                        TextField(
                          controller: pwd,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            focusColor: Color(0xff00ADB5),
                            hoverColor: Color(0xff00ADB5),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff00ADB5))),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'Password',
                            prefixIcon:
                                Icon(Icons.password, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(height: size.height * .07),
                        Container(
                          width: size.width,
                          height: size.height * .05,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black,
                              primary: Colors.grey[800],
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _pressloginButton();
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * .07),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage())),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Color(0xff00ADB5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
