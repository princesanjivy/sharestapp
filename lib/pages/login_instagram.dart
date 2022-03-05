import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharestapp/my_tabview.dart';

class InstaLogin extends StatefulWidget {
  @override
  _InstaLoginState createState() => _InstaLoginState();
}

class _InstaLoginState extends State<InstaLogin> {
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();
  String url = "https://www.instagram.com/accounts/login/";

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.onUrlChanged.listen((String value) {
      print(value);
      if (value == "https://www.instagram.com/") getCookies(value);
    });
  }

  getCookies(String currentUrl) async {
    final prefs = await SharedPreferences.getInstance();

    flutterWebViewPlugin.getAllCookies(currentUrl).then((sessionId) async {
      print(sessionId);
      await prefs.setString("sessionid", sessionId.toString());

      flutterWebViewPlugin.close();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyTabView(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebViewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(
        url: this.url,
        withJavascript: true,
        clearCache: true,
        clearCookies: true,
      ),
    );
  }
}
