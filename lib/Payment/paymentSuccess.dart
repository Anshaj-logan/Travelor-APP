import 'package:flutter/material.dart';

import '../user/Uhome.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        width: double.maxFinite,
        color: Colors.black,
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Uhome(),
                  ));
            },
            child: Text(
              'BACK HOME',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green[700],
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Payment Successfull....!',
              style: TextStyle(fontSize: 25, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
