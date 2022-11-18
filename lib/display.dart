import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fp7/datafile.dart';
import 'package:fp7/editing.dart';
import 'package:share_plus/share_plus.dart';

class display extends StatefulWidget {
  List<String> l = [];
  int index2;

  display(this.l, this.index2);

  @override
  State<display> createState() => _displayState();
}

class _displayState extends State<display> {
  PageController pc = PageController();
  int i = -1;

  List<String> item = ["item1", "item1", "item1", "item1", "item1"];
  BoxDecoration dec = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff377D71), Color(0xffFBA1A1), Color(0xffFBC5C5)]));

  @override
  void initState() {
    super.initState();
    int cnt = widget.index2;
    pc = PageController(initialPage: cnt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        iconTheme: IconThemeData(size: 28, color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(
                  'the best poetry app is live now go and install it!!\nhttps://play.google.com/store/apps/details?id=com.poetryapp.android');
            },
            icon: Icon(
              Icons.share,
              size: 28,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_sharp,
                size: 28,
                color: Colors.white,
              ))
        ],
        title: Text(
          "Poetry",
          style:
              TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Zoey"),
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.bd.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          dec = data.bd[index];
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: data.bd[index],
                                          child: Text("shayri"),
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10)),
                              );
                            },
                            context: context);
                      },
                      icon: Icon(
                        Icons.zoom_out_map,
                        size: 30,
                        color: Colors.black,
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${widget.index2 + 1}/${widget.l.length}",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        if (i == data.bd.length - 1) {
                          i = 0;
                        } else {
                          i++;
                        }
                        dec = data.bd[i];

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.cached_rounded,
                        size: 30,
                        color: Colors.black,
                      )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 200,
                  height: 500,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: dec,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      widget.index2 = value;

                      setState(() {});
                    },
                    controller: pc,
                    itemCount: widget.l.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.l[widget.index2],
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontFamily: "segoeuii"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    String temp = widget.l[widget.index2];
                    FlutterClipboard.copy(temp).then((value) =>
                        Fluttertoast.showToast(
                            msg: "Copied",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.white,
                            textColor: Colors.black87,
                            fontSize: 16.0));
                  },
                  icon: Icon(
                    Icons.file_copy,
                    color: Colors.black,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {
                    if (widget.index2 > 0) {
                      widget.index2 = widget.index2 - 1;
                    } else {
                      widget.index2 = widget.l.length - 1;
                    }
                    pc.jumpToPage(widget.index2);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.navigate_before,
                    color: Colors.black,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return editing(widget.l[widget.index2], dec);
                      },
                    ));
                  },
                  icon: Icon(
                    Icons.edit_off,
                    color: Colors.black,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {
                    if (widget.index2 < widget.l.length - 1) {
                      widget.index2 = widget.index2 + 1;
                    } else {
                      widget.index2 = 0;
                    }
                    pc.jumpToPage(widget.index2);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {
                    String temp = widget.l[widget.index2];
                    Share.share(temp);
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 28,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
