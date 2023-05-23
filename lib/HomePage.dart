import 'package:flutter/material.dart';
import 'package:one/ULogin.dart';
import 'package:one/agent/Asignup.dart';
import 'package:one/user/USignup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('Register'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ULogin()),
              );
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => USignup()));
                },
                child: Container(
                  height: 300,
                  width: 250,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Color(0xff00ADB5))),
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset('images/login.png'),
                        Text(
                          'User',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Asignup()));
                },
                child: Container(
                  height: 300,
                  width: 250,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Color(0xff00ADB5))),
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset('images/signup.png'),
                        Text(
                          'Travel Agency',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
