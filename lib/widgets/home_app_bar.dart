import 'package:flutter/material.dart';
class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading:  Icon(
            Icons.sort_rounded,
            size: 28,
          ),
          actions: [
            Padding(
              padding:
              EdgeInsets.only(right: 20.0),
              child:GestureDetector(
                onTap: () {},
                child: Icon(
                Icons.search,size: 26.0,
              ),
                  )
            ),
      Padding(
          padding:
          EdgeInsets.only(right: 20.0),
          child:GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert
            ),
          )
      ),
      ],
        ),
        body:
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              InkWell(
              onTap: () {},
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
      ),
    ),
              ],
     ),

        ),
    ),

        );
  }
}
