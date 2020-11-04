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
