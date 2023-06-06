import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Payment/paymentSuccess.dart';
import '../api.dart';
import 'Uhome.dart';

class AgentpackBooking extends StatefulWidget {
  String _id;
  AgentpackBooking(this._id);

  @override
  State<AgentpackBooking> createState() => _AgentpackBookingState();
}

class _AgentpackBookingState extends State<AgentpackBooking> {
  late SharedPreferences localStrorage;
  late String login_id;
  late String _id;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController modeController = TextEditingController();
  _boooking() async {
    localStrorage = await SharedPreferences.getInstance();
    login_id = (localStrorage.getString('loginId') ?? '');
    print('login_id ${login_id}');
    String U_id = "${widget._id}";
    print('U-id ${U_id}');

    var data = {
      "login_id": login_id.replaceAll('"', ''),
      "package_id": U_id,
      "email": emailController.text,
      "phone": phoneController.text,
      "mode": selectedValue1,
    };

    print(data);

    var res = await Api().authData(data, '/api/agent/agent-package-booking');
    var body = json.decode(res.body);
    print(res);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PaymentSuccess()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  List items = [
    "Google pay",
    "Paytm",
    "credit/debit/atm",
    "net banking",
  ];
  String? selectedValue1;
  @override
  Widget build(BuildContext context) {
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
              Text(
                'Email',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email',
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Phone No.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your phone no.',
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'payment Method',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.payment),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  hint: Text('Choose payment method'),
                  value: selectedValue1,
                  items: items
                      .map((type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (type) {
                    setState(() {
                      selectedValue1 = type;
                    });
                  }),
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
