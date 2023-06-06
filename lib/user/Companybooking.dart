import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/user/Uhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../api.dart';

class CompanyBooking extends StatefulWidget {
  String _id;
  CompanyBooking(this._id);

  @override
  State<CompanyBooking> createState() => _CompanyBookingState();
}

class _CompanyBookingState extends State<CompanyBooking> {
  late SharedPreferences localStrorage;
  late String user_id;
  late String _id;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController modeController = TextEditingController();
  _boooking() async {
    localStrorage = await SharedPreferences.getInstance();
    user_id = (localStrorage.getString('user_id') ?? '');
    print('User_id ${user_id}');
    String U_id = "${widget._id}";
    print('U-id ${U_id}');

    var data = {
      "user_id": user_id.replaceAll('"', ''),
      "company_id": U_id,
      "date": _date1.text,
    };

    print(data);

    var res = await Api().authData(data, '/api/company/book_comapany');
    var body = json.decode(res.body);
    print(res);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => Uhome()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  TextEditingController _date1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontFamily: 'Horizon',
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Book Now'),
          backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Uhome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText("Visting Time ",
                        textStyle: colorizeTextStyle, colors: colorizeColors),
                    ColorizeAnimatedText("11:00 AM - 6:00 PM",
                        textStyle: colorizeTextStyle, colors: colorizeColors),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _date1,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Choose Date"),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025));
                    if (pickeddate != null) {
                      setState(() {
                        _date1.text =
                            DateFormat('yyyy-MM-dd').format(pickeddate);
                      });
                    }
                  },
                ),
              ),
              // Text(
              //   'Phone No.',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // TextField(
              //     controller: phoneController,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Enter your phone no.',
              //     )),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   'payment Method',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // DropdownButtonFormField<String>(
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.payment),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide:
              //         BorderSide(width: 2.0, style: BorderStyle.solid),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black, width: 2),
              //       ),
              //     ),
              //     hint: Text('Choose payment method'),
              //     value: selectedValue1,
              //     items: items
              //         .map((type) => DropdownMenuItem<String>(
              //       value: type,
              //       child: Text(type),
              //     ))
              //         .toList(),
              //     onChanged: (type) {
              //       setState(() {
              //         selectedValue1 = type;
              //       });
              //     }),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff00ADB5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  _boooking();
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
