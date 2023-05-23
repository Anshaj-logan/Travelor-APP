import 'package:flutter/material.dart';
import 'package:one/user/Uiv.dart';
import 'package:one/user/Uivtype.dart';
class Uivcity extends StatefulWidget {
  const Uivcity({Key? key}) : super(key: key);

  @override
  State<Uivcity> createState() => _UivcityState();
}

class _UivcityState extends State<Uivcity> {
  List items=["Place1","Place2","Place3","Place4","Place5","Place6"];
  List images=["images/city1.jpg","images/city2.jpg","images/city3.jpg","images/city4.jpg","images/city5.jpg","images/city6.jpg"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor:Color(0xff00ADB5),
          title: Text('Type1 city'),
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Uivtype())),
    icon:Icon(Icons.arrow_back)
          ) ,
        ),
        body:
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(itemCount:items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,),
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Uiv()));
                },


                child: GridTile(
                  child:Image.asset(images[index],fit: BoxFit.fill,),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    leading: Text(items[index],style: TextStyle(
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
