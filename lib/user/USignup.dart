import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:one/ULogin.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/api.dart';

class USignup extends StatefulWidget {
  const USignup({Key? key}) : super(key: key);

  @override
  State<USignup> createState() => _USignupState();
}

class _USignupState extends State<USignup> {
  bool passwordVisible = false;
  bool passwordVisible1 = false;
  bool _isloading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordVisible1 = true;
  }

  final _formKey = GlobalKey<FormState>();
  void UserRegister() async {
    setState(() {
      _isloading = true;
    });
    var data = {
      "name": nameController.text,
      "email": emailController.text,
      "phonenumber": phoneController.text,
      "username": usernameController.text,
      "password": passwordController.text,
      "confirmpassword": confirmController.text,
    };
    var res = await Api().authData(data, '/api/register');
    var body = json.decode(res.body);
    print(body);
    if (body["success"] == true) {
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
      print('res${res}');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ULogin()));
    } else {
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
    }
  }

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
                        'images/signup.png',
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
                          'SIGNUP',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * .02),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            focusColor: Color(0xff00ADB5),
                            hoverColor: Color(0xff00ADB5),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff00ADB5))),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'Name ',
                            prefixIcon: Icon(Icons.drive_file_rename_outline,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: size.height * .02),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            focusColor: Color(0xff00ADB5),
                            hoverColor: Color(0xff00ADB5),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff00ADB5))),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'email ',
                            prefixIcon: Icon(Icons.email, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: size.height * .02),
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            focusColor: Color(0xff00ADB5),
                            hoverColor: Color(0xff00ADB5),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff00ADB5))),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'Phonenumber',
                            prefixIcon: Icon(Icons.phone, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: size.height * .02),
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            focusColor: Color(0xff00ADB5),
                            hoverColor: Color(0xff00ADB5),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff00ADB5))),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'User name',
                            prefixIcon: Icon(Icons.drive_file_rename_outline,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: size.height * .02),
                        TextField(
                          controller: passwordController,
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
                        SizedBox(height: size.height * .02),
                        TextField(
                          controller: confirmController,
                          obscureText: passwordVisible1,
                          decoration: InputDecoration(
                            focusColor: Color(0xff00ADB5),
                            hoverColor: Color(0xff00ADB5),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff00ADB5))),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: ' Confirm Password',
                            prefixIcon:
                                Icon(Icons.password, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible1
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible1 = !passwordVisible1;
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
                              UserRegister();
                            },
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ULogin())),
                              child: const Text(
                                'Sign in',
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
