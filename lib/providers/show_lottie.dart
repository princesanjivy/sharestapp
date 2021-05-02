import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowLottie with ChangeNotifier {
  bool show = false;
  SharedPreferences prefs;

  ShowLottie() {
    _initValue();
  }

  _initValue() async {
    prefs = await SharedPreferences.getInstance();
    bool show = prefs.getBool("key");

    if (show == null) {
      this.show = false;
    } else {
      this.show = show;
    }
  }

  bool getValue() {
    print(this.show);
    // notifyListeners();
    return this.show;
  }

  void setValue(bool show) {
    prefs.setBool("show", show).then((value) {
      this.show = show;
      notifyListeners();
    });
  }
}
