/*
 * @author Prince Sanjivy
 * @email sanjivy.android@gmail.com
 * @create date 2020-11-10 01:48:18
 * @modify date 2020-11-10 01:48:18
 */
import 'package:flutter/services.dart';

class ShareImage {
  String path;
  static const platform = const MethodChannel("com.princeappstudio.saveimage");
  ShareImage(this.path);

  void shareImage() async {
    print(path);
    if (path.contains("libCachedImageData")) {
      path = path.substring(path.lastIndexOf("/"), path.length);
      path = "libCachedImageData" + path;
      print(path);
    } else {
      path = path.substring(path.lastIndexOf("/"), path.length);
      print(path);
    }
    // path = path.replaceAll(
    //     "/data/user/0/com.princeappstudio.sharestapp/cache/", "");
    try {
      String result = await platform.invokeMethod("shareimage", {"path": path});
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
