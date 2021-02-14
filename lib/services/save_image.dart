/*
 * @author Prince Sanjivy
 * @email sanjivy.android@gmail.com
 * @create date 2020-11-10 01:48:10
 * @modify date 2020-11-10 01:48:10
 */
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image/image.dart';

class SaveImageToDir {
  final File file;
  String path;
  static const platform = const MethodChannel("com.princeappstudio.saveimage");
  SaveImageToDir(this.file);

  void saveImageToDir() async {
    var dir = "/storage/emulated/0/Pictures";

    var pictdir = await Directory('$dir/Sharestapp').create(recursive: true);
    Image image = decodeImage(file.readAsBytesSync());

    path = file.path.toString();
    print(path);
    path = path.substring(path.lastIndexOf("/"), path.length);
    print(path);

    final File myfile = File("${pictdir.path}$path")
      ..writeAsBytesSync(encodeJpg(image));

    try {
      String result =
          await platform.invokeMethod("saveimage", {"file": myfile.path});
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void saveVideoToDir() async {
    var dir = "/storage/emulated/0/Videos";

    var vidir = await Directory('$dir/Sharestapp').create(recursive: true);
    path = file.path.toString();
    print(path);
    path = path.substring(path.lastIndexOf("/"), path.length);
    print(path);

    Uint8List bytes = file.readAsBytesSync();
    final f = File("${vidir.path}$path")..writeAsBytesSync(bytes);
    print(f);

    try {
      String result =
          await platform.invokeMethod("saveimage", {"file": file.path});
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
