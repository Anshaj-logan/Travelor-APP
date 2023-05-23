import 'package:flutter/material.dart';
class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Drawer"),
        ),
        drawer: Drawer(
        child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
        const DrawerHeader(
        decoration: BoxDecoration(
        color: Colors.blue,
        ),
        child: Text('Drawer Header'),
        ),
        ListTile(
        leading: Icon(
        Icons.home,
        ),
        title: const Text('Page 1'),
        onTap: () {
        Navigator.pop(context);
        },
        ),
        ListTile(
        leading: Icon(
        Icons.train,
    ),
    title: const Text('Page 2'),
    onTap: () {
    Navigator.pop(context);
    },
    ),
    ],
    ),
    ),
    body: Center(
    child: Column(
    children: [
    SizedBox(
    height: 50,
    ),
    ],
    ),
    ),
      ),
    );

  }
}
