import 'package:flutter/material.dart';
import 'package:sharestapp/getimage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imageurl;
  String instaposturl = "https://www.instagram.com/p/CEuhOEsBtYJ";

  @override
  void initState() {
    super.initState();
    
    GetImageFromUrl(instaposturl).myimage().then((value) {
      // print(value);
      setState(() {
        _imageurl = value;
      });
    });
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
