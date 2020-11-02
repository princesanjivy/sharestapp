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
    return GridView.builder(
      itemCount: files.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 15.0, crossAxisSpacing: 3.0),
      itemBuilder: (context, index) {
        File myfile = new File(files[index]);
        return Card(
          elevation: 5.0,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 180.0,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(myfile, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.share,
                    ),
                    onPressed: () {},
                    color: Colors.blue,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.save_alt_rounded,
                    ),
                    onPressed: () {},
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
