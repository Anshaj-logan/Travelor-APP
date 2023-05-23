import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one/user/Uivcity.dart';
import 'package:one/user/Utype.dart';

import '../api.dart';
class Uivtype extends StatefulWidget {
  const Uivtype({Key? key}) : super(key: key);

  @override
  State<Uivtype> createState() => _UivtypeState();
}

class _UivtypeState extends State<Uivtype> {
 // List items=["IT","Commercial","Type3","Type4","Type5","Type6"];
  List images=["images/city1.jpg","images/city2.jpg","images/city3.jpg","images/city4.jpg","images/city5.jpg","images/city6.jpg"];

  List loadeddata = [];
  String tripid='';
  _fetchData() async {
    var res = await Api().getData('/api/category/view_user_category');

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];

      setState(() {
        loadeddata = items;
        print(loadeddata);
      });
    } else {
      setState(() {
        loadeddata = [];
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Select IV type'),
          backgroundColor:Color(0xff00ADB5),
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Utype())),

              icon: Icon(Icons.arrow_back)),
        ),
        body:
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(itemCount:loadeddata.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,),
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>Uivcity() ));
                },


                child: GridTile(
                  child:Image.asset(images[index],fit: BoxFit.fill,),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    leading: Text(loadeddata[index],style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
              );
            },
          ),

        ),

      ),
    );
  }
}
