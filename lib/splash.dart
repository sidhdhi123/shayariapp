import 'package:flutter/material.dart';
import 'package:fp7/index.dart';
import 'package:permission_handler/permission_handler.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();

    next();
  }

  next() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [Permission.storage].request();
    }

    await Future.delayed(Duration(seconds: 1));


    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return index();

      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff377D71),
          Color(0xffFBA1A1),
          Color(0xffFBC5C5)
        ])),
        child: Center(
          child: Text(
            "Love-Poetry",
            style: TextStyle(fontSize: 34, fontFamily: "Zoey"),
          ),
        ),
      ),
    );
  }
}
