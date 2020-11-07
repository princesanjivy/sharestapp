import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharestapp/font_awesome_icons.dart';
import 'package:sharestapp/getimage.dart';
import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sharestapp/saveimage.dart';
import 'package:sharestapp/shareimage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String con =
      "Sharestapp is an open source application that lets an end user to directly share an image from Instagram to other apps in an exact image format and also allows the user to Save the respected image in the local storage.";
  String _imageurl;
  String instaposturl;
  String _sharedText;
  StreamSubscription _intentDataStreamSubscription;
  var f;

  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
        instaposturl = _sharedText;
        instaposturl = instaposturl.substring(
            instaposturl.indexOf("ttps://") - 1,
            instaposturl.indexOf("?igshid"));

        print(instaposturl);
        GetImageFromUrl(instaposturl).myimage().then((value) {
          setState(() {
            print(value);
            _imageurl = value;
            _saveImagetoCache(_imageurl);
          });
        });
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _intentDataStreamSubscription.cancel();
  }

  _saveImagetoCache(i) async {
    if (_imageurl != null) {
      var myFile = await DefaultCacheManager().downloadFile(i);
      setState(() {
        f = myFile;
        _showDialog(f);
      });
    }
  }

  void _showDialog(var file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Share to WhatsApp"),
          content: Image.file(file.file),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                SaveImageToDir(file.file).saveImageToDir();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Share"),
              onPressed: () {
                ShareImage(file.file.path).shareImage();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              // bottom: 10,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey[300],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    con,
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.blue,
                                size: 30,
                              ),
                              Text("Rate & Review"),
                            ],
                          ),
                          onTap: () {
                            print(MediaQuery.of(context).size.width);
                          },
                        ),
                        InkWell(
                          child: Icon(
                            Icons.share,
                            color: Colors.blue,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          top: 10,
                          left: 10,
                          right: 5,
                        ),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.blue,
                                  ),
                                  Text("More Apps"),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                "Check other apps published on Google Play Store",
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          top: 5,
                          left: 10,
                          right: 5,
                        ),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.clear_all,
                                    color: Colors.blue,
                                  ),
                                  Text("Clear Cache"),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                "Click here to remove your app cache",
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 5,
                          left: 10,
                          right: 5,
                        ),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: Colors.blue,
                                  ),
                                  Text("About"),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                "More info about Sharestapp",
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          top: 10,
                          left: 5,
                          right: 10,
                        ),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "30",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 70),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.blue,
                                  ),
                                  Text("Images shared"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 5,
                          left: 5,
                          right: 10,
                        ),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.code,
                                    color: Colors.blue,
                                  ),
                                  Text("Developers"),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                "Click here to know about the developers",
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
