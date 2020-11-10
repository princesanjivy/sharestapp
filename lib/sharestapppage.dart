/* 
 * @author Prince Sanjivy, Vignesh Hendrix
 * @email vigneshvicky8384@gmail.com,
 * @email sanjivy.android@gmail.com, 
 * @create date 2020-11-10 01:48:26
 * @modify date 2020-11-10 01:48:26
 * @desc [description]
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as i;
import 'package:path_provider/path_provider.dart';
import 'package:sharestapp/shareimage.dart';

class MySharestappPage extends StatefulWidget {
  const MySharestappPage({Key key}) : super(key: key);

  @override
  _MySharestappPageState createState() => _MySharestappPageState();
}

class _MySharestappPageState extends State<MySharestappPage> {
  List files = new List();
  bool _notcreated = true;
  var show;
  var _savedpath = "/storage/emulated/0/Pictures/Sharestapp";

  @override
  void initState() {
    super.initState();

    _checkDirExists();
  }

  _checkDirExists() async {
    bool exists = await Directory(_savedpath).exists();

    if (exists) {
      print("Exists");
      if (this.mounted)
        setState(() {
          _notcreated = !_notcreated;

          files = Directory(_savedpath)
              .listSync()
              .map((item) => item.path)
              .where((item) => item.endsWith(".jpg"))
              .toList();

          show = files.length;
        });
    } else {
      print("Nope");
      if (this.mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _notcreated
        ? Center(
            child: Text("No images yet saved!"),
          )
        : GridView.builder(
            itemCount: files.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 3.0),
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
                            i.Image image =
                                i.decodeImage(myfile.readAsBytesSync());

                            var path = myfile.path;
                            path = path.substring(
                                path.lastIndexOf("/"), path.length);

                            final File f = File("${cacheDir.path}$path")
                              ..writeAsBytesSync(i.encodeJpg(image));
                            print(f);
                            ShareImage(f.path).shareImage();
                            // SnackBar(content: Text("Image Shared!"));
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
