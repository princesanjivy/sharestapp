import 'package:flutter/services.dart';

class InterstitialAd {
  final platform = new MethodChannel("com.princeappstudio.ad");

  void showAd() async {
    try {
      String result = await platform.invokeMethod("showad");
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
