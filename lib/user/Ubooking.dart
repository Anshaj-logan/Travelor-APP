import 'package:flutter/material.dart';
import 'package:one/user/Udetails.dart';
import 'package:one/user/Uothers.dart';
import 'package:one/user/Usubmit.dart';
class Ubooking extends StatefulWidget {
  const Ubooking({Key? key}) : super(key: key);

  @override
  State<Ubooking> createState() => _UbookingState();
}

class _UbookingState extends State<Ubooking> {
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
        appBar: AppBar(title: Text('Book Now'),backgroundColor: Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Udetails())),

              icon: Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Email',textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email',
                  )),
              SizedBox(height: 10,),
              Text('Phone No.',textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your phone no.',
                  )),
              SizedBox(height: 10,),
              Text('payment Method',textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
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
              SizedBox(height: 20,),
              ElevatedButton(style: ElevatedButton.styleFrom(
                  primary: Color(0xff00ADB5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Usubmit())),
                child: Text('OK'),
              ),
            ],
          ),
        ),


      ),
    );
  }
}
