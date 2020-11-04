import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart' as i;
import 'package:path_provider/path_provider.dart';
import 'package:sharestapp/saveimage.dart';
import 'package:sharestapp/shareimage.dart';

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
          elevation: 4,
          child: GridTile(
            child: Image.file(
              myfile,
              fit: BoxFit.cover,
            ),
            footer: Container(
              color: Colors.white30,
              alignment: Alignment.centerRight,
              // padding: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.black87,
                    ),
                    onPressed: () async {
                      var cacheDir = await getTemporaryDirectory();
                      print(cacheDir);
                      i.Image image = i.decodeImage(myfile.readAsBytesSync());

                      var path = myfile.path;
                      path = path.substring(path.lastIndexOf("/"), path.length);

                      final File f = File("${cacheDir.path}$path")
                        ..writeAsBytesSync(i.encodeJpg(image));
                      print(f);
                      ShareImage(f.path).shareImage();
                      // SnackBar(content: Text("Image Shared!"));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.save_alt,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      SaveImageToDir(myfile).saveImageToDir();
                      SnackBar(content: Text("Image Saved!"));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
