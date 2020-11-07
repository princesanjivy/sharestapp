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
          TextField(
            decoration: InputDecoration(
              hintText: 'Drop the image link here',
              suffixIcon: IconButton(
                onPressed:
                    () {}, //code to save image to local should be placed here.
                icon: Icon(
                  Icons.file_download,
                  color: Colors.blueAccent,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              contentPadding: EdgeInsets.all(15.0),
              prefixIcon: Icon(
                Icons.link,
                color: Colors.blueAccent,
              ),
              hintStyle: GoogleFonts.raleway(
                letterSpacing: 1.0,
              ),
            ),
            autofocus: false,
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1.0,
                color: Colors.grey[350],
              ),
            ),
            height: 255,
            width: 450,
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
                  SizedBox(
                    height: 40.0,
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Sharestapp is an open source application that lets an end user to directly share an image from Instagram to other apps in an exact image format and also allows the user to Save the respected image in the local storage.',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.star_border,
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
            height: 30.0,
          ),
          Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    print(
                        ' Redirect to Playstore'); //Place the code here to redirect the user to playstore
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
                    height: 100,
                    width: 190,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton.icon(
                            onPressed: () {},
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
                width: 60.0,
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
                    height: 100,
                    width: 190,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.share),
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
            height: 30.0,
          ),
          Row(
            children: [
              SizedBox(
                width: 20.0,
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
                    height: 100,
                    width: 190,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.cached),
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
                width: 60.0,
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
                    height: 100,
                    width: 190,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FlatButton.icon(
                            onPressed: () {},
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
        ],
      ),
    );
  }
}
