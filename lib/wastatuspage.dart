import 'dart:io';
import 'package:flutter/material.dart';

class MyWAStatusPage extends StatefulWidget {
  const MyWAStatusPage({Key key}) : super(key: key);

  @override
  _MyWAStatusPageState createState() => _MyWAStatusPageState();
}

class _MyWAStatusPageState extends State<MyWAStatusPage> {
  List files = new List();

  @override
  void initState() {
    super.initState();

    setState(() {
      files = Directory("/storage/emulated/0/WhatsApp/Media/.Statuses")
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg"))
          .toList();
      
      print(files.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: files.length,
      itemBuilder: (BuildContext context, int index) {
        File myfile = new File(files[index]);
        // print(myfile);
        return Center(
          child: Stack(
            children: [
              Container(
                child: Image.file(myfile),
                width: 150,
                height: 150,
              ),
            ],
          ),
        );
      },
    ));
  }
}
