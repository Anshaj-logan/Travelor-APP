import 'package:flutter/material.dart';
import 'package:one/widgets/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: HomeAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [
                  Expanded(child: Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: 160,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage("images/city${index+1}.jpg"),
                              fit: BoxFit.cover,
                              opacity: 0.7,
                            ),
                          ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.bookmark_border_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text("City Name", style: TextStyle(color: Colors.white,
                                  fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                      );
                    }
                    ),
                  )),
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
              )
            ],
            ),
          ),
        ),
      ),
    );
  }
}
