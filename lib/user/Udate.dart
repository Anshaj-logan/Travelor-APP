import 'package:flutter/material.dart';
import 'package:one/user/Uothers.dart';
import 'package:one/user/Uplan.dart';
import 'package:intl/intl.dart';

class Udate extends StatefulWidget {
  late String fromloc;
  late String whereloc;
  Udate(this.fromloc, this.whereloc);

  @override
  State<Udate> createState() => _UdateState();
}

class _UdateState extends State<Udate> {
  late String fromloc;
  late String whereloc;
  late String startdate;
  late String enddate;
  TextEditingController _date1 = TextEditingController();
  TextEditingController _date2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text("Select date"),
          leading: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Uplan())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/calendar.png"),
                  radius: 75,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _date1,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Select start date"),
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _date2,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Select end date"),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025));
                    if (pickeddate != null) {
                      setState(() {
                        _date2.text =
                            DateFormat('yyyy-MM-dd').format(pickeddate);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.cyan),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Uplan())),
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
                            style:
                                ElevatedButton.styleFrom(primary: Colors.cyan),
                            onPressed: () {
                              fromloc = "${widget.fromloc}";
                              print('from location ${fromloc}');
                              whereloc = "${widget.whereloc}";
                              print('where location ${whereloc}');
                              startdate = _date2.text;
                              enddate = _date2.text;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Uothers(fromloc,
                                          whereloc, startdate, enddate)));
                            },
                            child: Text('Next',
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
    );
  }
}
