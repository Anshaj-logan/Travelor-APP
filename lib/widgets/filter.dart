import 'package:flutter/material.dart';
import 'package:one/user/Ucity.dart';

class filter extends StatefulWidget {
  const filter({Key? key}) : super(key: key);

  @override
  State<filter> createState() => _filterState();
}

class _filterState extends State<filter> {
  bool? isChecked = false;
  bool? isChecked1 = false;
  bool? isChecked2 = false;
  bool? isChecked3 = false;
  bool? isChecked4 = false;
  bool? isChecked5 = false;
  bool? isChecked6 = false;
  bool? isChecked7 = false;
  bool? isChecked8 = false;
  bool? isChecked9 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text("Filters"),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back)),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("RESET"),
                      ))),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Destination type:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("Kerala"),
                        activeColor: Colors.red,
                        value: isChecked,
                        onChanged: (val) {
                          setState(() {
                            isChecked = val;
                          });
                        }),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("India"),
                        activeColor: Colors.red,
                        value: isChecked1,
                        onChanged: (val) {
                          setState(() {
                            isChecked1 = val;
                          });
                        }),
                    Text(
                      "Budget:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("Below 5000"),
                        activeColor: Colors.red,
                        value: isChecked2,
                        onChanged: (val) {
                          setState(() {
                            isChecked2 = val;
                          });
                        }),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("10000 - 20000"),
                        activeColor: Colors.red,
                        value: isChecked3,
                        onChanged: (val) {
                          setState(() {
                            isChecked3 = val;
                          });
                        }),
                    Text(
                      "Duration (Days) :",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("1 - 3"),
                        activeColor: Colors.red,
                        value: isChecked4,
                        onChanged: (val) {
                          setState(() {
                            isChecked4 = val;
                          });
                        }),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("4 - 6"),
                        activeColor: Colors.red,
                        value: isChecked5,
                        onChanged: (val) {
                          setState(() {
                            isChecked5 = val;
                          });
                        }),
                    Text(
                      "Activity",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("Waterfall"),
                        activeColor: Colors.red,
                        value: isChecked6,
                        onChanged: (val) {
                          setState(() {
                            isChecked6 = val;
                          });
                        }),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("Temple"),
                        activeColor: Colors.red,
                        value: isChecked7,
                        onChanged: (val) {
                          setState(() {
                            isChecked7 = val;
                          });
                        }),
                    Text(
                      "Month of travel",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("Jan - March"),
                        activeColor: Colors.red,
                        value: isChecked8,
                        onChanged: (val) {
                          setState(() {
                            isChecked8 = val;
                          });
                        }),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("April - May"),
                        activeColor: Colors.red,
                        value: isChecked9,
                        onChanged: (val) {
                          setState(() {
                            isChecked9 = val;
                          });
                        }),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text('Apply filter',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black))),
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
