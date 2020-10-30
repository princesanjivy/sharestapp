import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyWAStatusPage extends StatefulWidget {
  const MyWAStatusPage({Key key}) : super(key: key);

  @override
  _MyWAStatusPageState createState() => _MyWAStatusPageState();
}

class _MyWAStatusPageState extends State<MyWAStatusPage> {
  String _imageurl =
      "https://instagram.fmaa10-1.fna.fbcdn.net/v/t51.2885-15/e35/118780224_1006561836528425_4525678400212770449_n.jpg?_nc_ht=instagram.fmaa10-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=HC9BPxGKfWkAX9MgOOh&tp=18&oh=771e363ebc385de574db8869000b28ad&oe=5FC746C2";
  var myfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: RaisedButton(
              onPressed: () async {
                myfile = await DefaultCacheManager().downloadFile(_imageurl);
                setState(
                  () {
                    print(myfile.file.path);
                  },
                );
              },
              child: Text("Save to cache"),
            ),
          ),
          myfile == null ? Text("Hello") : Image.file(myfile.file),
        ],
      ),
    );
  }
}
