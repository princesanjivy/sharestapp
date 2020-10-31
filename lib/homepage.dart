import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sharestapp/getimage.dart';
import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

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
          title: new Text("Share to WhatsApp"),
          content: new Image.file(file.file),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
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
    return Container(
      child: f == null ? Text("Hello, world!") : Text("welcome"),
    );
  }
}
