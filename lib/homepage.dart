import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharestapp/font_awesome_icons.dart';
import 'package:sharestapp/getimage.dart';
import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sharestapp/saveimage.dart';
import 'package:sharestapp/shareimage.dart';
import 'package:url_launcher/url_launcher.dart';

void redirect(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Sorry,could not launch $url';
  }
}

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
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: h * 0.030,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1.0,
                color: Colors.grey[350],
              ),
            ),
            height: h * 0.3,
            width: w * 0.9,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: 0.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sharestapp',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.0,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 2.0,
                      right: 5.0,
                      bottom: 5.0,
                      top: 35.0,
                    ),
                    child: Text(
                      'Sharestapp is an open source application that lets an end user to directly share an image from Instagram to other apps in an exact image format and also allows the user to Save the respected image in the local storage.',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 17.0,
                        letterSpacing: 0.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.star_border_rounded,
                        ),
                        label: Text(
                          'RATE & REVIEW',
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                        splashColor: Colors.blue,
                        padding: EdgeInsets.all(0.0),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      IconButton(
                        icon: Icon(Icons.share), //share button ONpressed
                        onPressed: () {},
                        splashColor: Colors.blue,
                        splashRadius: 40,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: h * 0.030,
          ),
          Row(
            children: [
              SizedBox(
                width: 25.0,
              ),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    redirect('https://play.google.com/store');
                  },
                  splashColor: Colors.blue,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey[350],
                      ),
                    ),
                    height: h * 0.116,
                    width: w * 0.395,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton.icon(
                            onPressed: () {
                              redirect('https://play.google.com/store');
                            },
                            icon: Icon(FontAwesome.cart_plus),
                            label: Text(
                              'More Apps',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            splashColor: Colors.lightBlue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Text(
                                'Check other apps published on Google Play Store.',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: w * 0.111,
              ),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {}, //redirecttoplaystore.
                  splashColor: Colors.blue,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey[350],
                      ),
                    ),
                    height: h * 0.116,
                    width: w * 0.395,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.share_outlined),
                            label: Text(
                              'Images Shared',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            splashColor: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.030,
          ),
          Row(
            children: [
              SizedBox(
                width: 25.0,
              ),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () async {
                    await DefaultCacheManager().emptyCache();
                  }, //cache
                  splashColor: Colors.blue,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey[350],
                      ),
                    ),
                    height: h * 0.116,
                    width: w * 0.395,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.cached_outlined),
                            label: Text(
                              'Clear Cache',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            splashColor: Colors.lightBlue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Text(
                                'Click here to remove your App Cache.',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: w * 0.111,
              ),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.pushNamed(context, '/aboutus');
                  },
                  splashColor: Colors.blue,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey[350],
                      ),
                    ),
                    height: h * 0.116,
                    width: w * 0.395,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/aboutus');
                            },
                            icon: Icon(Icons.code),
                            label: Text(
                              'Developers',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            splashColor: Colors.lightBlue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Text(
                                'Click here to know About the Devs of Sharestapp.',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 90.0),
            child: OutlineButton(
              onPressed: () {
                showAboutDialog(
                  //aboutdialogcode to be modified later.
                  context: context,
                  applicationIcon: Icon(
                      Icons.share_outlined), //must add our icon once designed.
                  applicationName: 'Sharestapp',
                  applicationVersion: '1.0.0',
                );
              },
              child: Text('More Info'),
            ),
          )
        ],
      ),
    );
  }
}
