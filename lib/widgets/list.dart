import 'package:flutter/material.dart';

class list extends StatefulWidget {
  const list({Key? key}) : super(key: key);

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  List item=["item1"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body:ListView.builder(
            itemCount
                : item.length,

          itemBuilder: (context,index){
              return ListTile(

                title: Text(item[index]),
              );

          }),
      ),
    );
  }
}

