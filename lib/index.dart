import 'package:flutter/material.dart';

import 'package:fp7/datafile.dart';

import 'package:fp7/shayrilist.dart';
import 'package:permission_handler/permission_handler.dart';

class index extends StatefulWidget {
  const index({Key? key}) : super(key: key);

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  Color c = Colors.white;
  Color c1 = Colors.black;
  List<bool> b = List.filled(data.name.length, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Color(0xff377D71),
        toolbarHeight: 100,
        title: Text(
          "Love-Poetry",
          style:
              TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Zoey"),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xff377D71),
                Color(0xff377D71),
              ])),
        ),
      ),
      body: ListView.builder(
        itemCount: data.name.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTapDown: (details) {
              setState(() {
                b[index]=true;
              });
            },
            onTapUp: (details) {
              setState(() {});
              b[index]=false;
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return slist(index);
                },
              ));
            },
            onTapCancel: () {
              setState(() {
                b[index]=false;
              });
            },
            onTap: () {

            },
            child: Card(
              elevation: 5,
              shadowColor: Colors.grey,
              color: c,
              child: ListTile(
                tileColor: (b[index]) ? Color(0xff377D71) : Colors.white,
                title: Text(
                  data.name[index],
                  style: TextStyle(color: c1, fontFamily: "segoeuii"),
                ),
                leading: Container(
                  width: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(data.pic[index]),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
