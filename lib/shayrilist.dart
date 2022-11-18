import 'package:flutter/material.dart';

import 'package:fp7/datafile.dart';
import 'package:fp7/display.dart';

class slist extends StatefulWidget {
  int index;

  slist(this.index);

  @override
  State<slist> createState() => _slistState();
}

class _slistState extends State<slist> {
  List<bool> b = [];
  List<String> l = [];

  initState() {
    if (widget.index == 0) {
      l = data.friend;
    } else if (widget.index == 1) {
      l = data.funny;
    } else if (widget.index == 2) {
      l = data.love;
    } else if (widget.index == 3) {
      l = data.sad;
    } else if (widget.index == 4) {
      l = data.birthday;
    }
    b = List.filled(l.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          iconTheme: IconThemeData(size: 28, color: Colors.white),
          title: Text(
            "${data.name[widget.index]}-Poetry",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontFamily: "Zoey"),
          ),
          // backgroundColor: Color(0xff377D71),
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
          itemCount: l.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shadowColor: Colors.grey,
              color: Colors.white,
              child: InkWell(
                onTapDown: (details) {
                  setState(() {
                    b[index] = true;
                  });
                },
                onTapUp: (details) {
                  setState(() {});
                  b[index] = false;
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return display(l, index);
                    },
                  ));
                },
                onTapCancel: () {
                  setState(() {
                    b[index] = false;
                  });
                },
                onTap: () {},
                child: ListTile(
                  tileColor: (b[index]) ? Color(0xff377D71) : Colors.white,
                  title: Text(
                    l[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Colors.black, fontFamily: "segoeuii"),
                  ),
                  leading: Container(
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(data.pic[widget.index]))),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
