import 'package:flutter/material.dart';
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
  StreamSubscription _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();

    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        img();
        instaposturl = value;
        print("Shared: $instaposturl");
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        img();
        instaposturl = value;
        print("Shared: $instaposturl");
      });
    });
  }

  void img() {
    GetImageFromUrl(instaposturl).myimage().then((value) {
      print(value);
      setState(() {
        _imageurl = value;
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _imageurl == null
          ? Center(child: CircularProgressIndicator())
          : Image.network(_imageurl),
    );
  }
}
