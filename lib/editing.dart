import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'dart:async';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fp7/datafile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class editing extends StatefulWidget {
  String l;
  BoxDecoration dec;

  editing(this.l, this.dec);

  @override
  State<editing> createState() => _editingState();
}

class _editingState extends State<editing> {
  Color c = Colors.pinkAccent;
  Color t = Colors.black;
  double size = 30;
  String app = "";
  int i = -1;
  BoxDecoration dec = BoxDecoration();
  String font = "segoeuii";
  bool single = false;
  String folderpath = "";

  List<Color> colorlist = [
    Colors.red,
    Colors.brown,
    Colors.indigo,
    Colors.green,
    Colors.purpleAccent,
    Colors.amber,
    Colors.blueGrey,
    Colors.pink,
    Colors.pinkAccent,
    Colors.teal,
    Colors.white,
    Colors.black87,
    Colors.lightGreenAccent,
    Colors.grey,
    Colors.orange,
    Colors.blue,
    Colors.lightGreen,
    Colors.cyanAccent,
    Colors.yellowAccent,
    Colors.amberAccent,
    Colors.indigoAccent,
    Colors.deepOrange,
    Colors.cyan,
    Colors.deepPurpleAccent,
    Colors.redAccent
  ];

  GlobalKey _globalKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    dec = widget.dec;
    create_dir();
  }

  create_dir() async {
    // Directory dir = Directory((Platform.isAndroid
    //             ? await getExternalStorageDirectory() //FOR ANDROID
    //             : await getApplicationSupportDirectory() //FOR IOS
    //         )!
    //         .path +
    //     '/poetry App');
    var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS) +
        "/poetry App";

    Directory dir = Directory(path);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
      print("Already created!!");
    } else {
      dir.create();
      print("folder is now on!!");
    }

    folderpath = dir.path;
  }

  Future<Uint8List> _capturePng() async {
    var pngBytes;
    try {
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      // print(pngBytes);
      // print(bs64);
      // setState(() {});
    } catch (e) {
      print(e);
    }
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        iconTheme: IconThemeData(size: 28, color: Colors.white),
        title: Text(
          "Edit",
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
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 40, right: 20),
                    alignment: Alignment.center,
                    child: RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: single ? BoxDecoration(color: c) : dec,
                        child: SingleChildScrollView(
                          child: Text(
                            "${app}\n${widget.l}\n${app}",
                            style: TextStyle(
                                fontSize: size, color: t, fontFamily: font),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.black87.withOpacity(0.80),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (i == data.bd.length - 1) {
                                  i = 0;
                                } else {
                                  i++;
                                }
                                single = false;
                                dec = data.bd[i];

                                setState(() {});
                              },
                              icon: Icon(
                                Icons.cached_rounded,
                                size: 30,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    barrierColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Container(
                                        height: 620,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: GridView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: data.bd.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          single = false;

                                                          dec = data.bd[index];
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              data.bd[index],
                                                          child: Text(
                                                            "shayri",
                                                            style: TextStyle(
                                                                fontSize: 34),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing:
                                                                10))),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                  Icons.cancel_rounded,
                                                  size: 34,
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                    context: context);
                              },
                              icon: Icon(
                                Icons.zoom_out_map,
                                size: 30,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          des("Background"),
                          des("Text color"),
                          des("Share"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          des("Font"),
                          des("Emoji"),
                          des("Text size"),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  des(String s) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (s == "Background") {
            showModalBottomSheet(
                isDismissible: false,
                barrierColor: Colors.transparent,
                builder: (context) {
                  return Container(
                    height: 150,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: GridView.builder(
                                itemCount: colorlist.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      single = true;

                                      c = colorlist[index];

                                      setState(() {});
                                    },
                                    child: Container(
                                      color: colorlist[index],
                                    ),
                                  );
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10))),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_rounded,
                              color: Colors.black87,
                              size: 34,
                            ))
                      ],
                    ),
                  );
                },
                context: context);
          } else if (s == "Text color") {
            showModalBottomSheet(
                barrierColor: Colors.transparent,
                isDismissible: false,
                builder: (context) {
                  return Container(
                    height: 300,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: MaterialPicker(
                                onColorChanged: (value) {
                                  setState(() {
                                    t = value;
                                  });
                                },
                                pickerColor: t),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_rounded,
                              size: 34,
                            ))
                      ],
                    ),
                  );
                },
                context: context);
          } else if (s == "Share") {
            permission();
            DateTime now = DateTime.now();
            String imgname =
                "${now.year}${now.month}${now.day}_pA_${now.hour}${now.minute}${now.second}${now.millisecond}";
            String imagepath = "${folderpath}/Image_${imgname}.jpg";
            File file = File("${imagepath}");
            file.create().then(
              (value) {
                print(value.path);
                _capturePng().then(
                  (value) {
                    file.writeAsBytes(value).then(
                      (value) {
                        print("file write");
                        Share.shareFiles(['${file.path}']);
                      },
                    );
                  },
                );
              },
            );
          } else if (s == "Font") {
            showModalBottomSheet(
                isDismissible: false,
                builder: (context) {
                  return Container(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.fstyle.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                font = data.fstyle[index];
                                setState(() {});
                              },
                              child: Container(
                                color: Colors.black87,
                                width: 90,
                                height: 20,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 30, top: 30),
                                child: Text(
                                  "Shayri",
                                  style: TextStyle(
                                      fontFamily: data.fstyle[index],
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                            );
                          },
                        )),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_rounded,
                              size: 34,
                            ))
                      ],
                    ),
                  );
                },
                context: context);
          } else if (s == "Emoji") {
            showModalBottomSheet(
                backgroundColor: Colors.white,
                barrierColor: Colors.transparent,
                isDismissible: false,
                builder: (context) {
                  return Container(
                    height: 150,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 4,
                              color: Colors.black,
                            );
                          },
                          itemCount: data.emoji.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              shadowColor: Colors.black,
                              child: InkWell(
                                onTap: () {
                                  if (data.emoji[index] == "No Emoji") {
                                    app = "";
                                  } else {
                                    app = data.emoji[index];
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${data.emoji[index]}",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_rounded,
                              size: 34,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  );
                },
                context: context);
          } else if (s == "Text size") {
            showModalBottomSheet(
                barrierColor: Colors.transparent,
                isDismissible: false,
                builder: (context) {
                  return Container(
                    height: 160,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: StatefulBuilder(
                          builder: (context, setState1) {
                            return Slider(
                                activeColor: Colors.black,
                                inactiveColor: Colors.black12,
                                thumbColor: Colors.black,
                                min: 20,
                                max: 50,
                                onChanged: (value) {
                                  size = value;
                                  setState(() {});
                                  setState1(() {});
                                },
                                value: size);
                          },
                        )),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_rounded,
                              color: Colors.black87,
                              size: 34,
                            ))
                      ],
                    ),
                  );
                },
                context: context);
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xffFBA1A1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(
            s,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  permission() async {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      await [Permission.storage].request();
    }
  }
}
