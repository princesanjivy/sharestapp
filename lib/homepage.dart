/**
 * @author Prince Sanjivy, Vignesh Hendrix
 * @email sanjivy.android@gmail.com,
 * @create date 2020-11-10 01:47:05
 * @modify date 2020-11-10 01:47:05
 * @desc [description]
 */
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharestapp/aboutus.dart';
import 'package:sharestapp/font_awesome_icons.dart';
import 'package:sharestapp/getimage.dart';
import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sharestapp/saveimage.dart';
import 'package:sharestapp/shareimage.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imageurl;
  String instaposturl;
  String _sharedText;
  StreamSubscription _intentDataStreamSubscription;
  String con =
      "Sharestapp is an open source application that let's an end user to directly share an image/video from Instagram to other apps in an exact image/video format, and also allows the user to save in mobile's local storage.";
  var f;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();

    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      showLoadingDialog(context, _keyLoader);
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
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      setState(() {
        f = myFile;
        _showDialog(f);
      });
    }
  }

  void _showDialog(var file) {
    showDialog(
      context: context,
      barrierDismissible: false,
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

  showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              key: key,
              title: Text("Please wait"),
              content: Center(
                child: CircularProgressIndicator(),
                heightFactor: 1 / 2.5,
              ),
            ),
          );
        });
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
                  color: Colors.grey[200],
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
                          // radius: 3,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.blue,
                                size: 30,
                              ),
                              Text(
                                "Rate & Review",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            print(MediaQuery.of(context).size.width);
                          },
                        ),
                        InkWell(
                          splashColor: Colors.blue[100],
                          child: Icon(
                            Icons.share_rounded,
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
                        child: InkWell(
                          onTap: () async {
                            await launch(
                                "https://play.google.com/store/apps/dev?id=6439925551269057866");
                          },
                          borderRadius: BorderRadius.circular(10),
                          highlightColor: Colors.blue[200],
                          splashColor: Colors.blue[200],
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 30) / 2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[200],
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
                                    Text(
                                      "More Apps",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          top: 5,
                          left: 10,
                          right: 5,
                        ),
                        child: InkWell(
                          onTap: () {
                            //[TODO]
                          },
                          borderRadius: BorderRadius.circular(10),
                          highlightColor: Colors.blue[200],
                          splashColor: Colors.blue[200],
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 30) / 2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[200],
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
                                    Text(
                                      "Clear Cache",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 5,
                          left: 10,
                          right: 5,
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10),
                          highlightColor: Colors.blue[200],
                          splashColor: Colors.blue[200],
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 30) / 2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[200],
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
                                    Text(
                                      "About",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
                              color: Colors.grey[200],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "3",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 70),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Icon(
                                  //   Icons.share,
                                  //   color: Colors.blue,
                                  // ),
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
                        child: InkWell(
                          onTap: () {
                            // Timer(Duration(milliseconds: 200), () {
                            Navigator.pushNamed(context, "/aboutus");
                            // Navigator.push(
                            // context, FadeRoute(page: AboutUs()));
                            // });
                          },
                          borderRadius: BorderRadius.circular(10),
                          highlightColor: Colors.blue[200],
                          splashColor: Colors.blue[200],
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 30) / 2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[200],
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
                                    Text(
                                      "Developers",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
