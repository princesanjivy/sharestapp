import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharestapp/my_tabview.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

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

    getAllCookies(currentUrl).then((value) async {
      print(value);
      await prefs.setString("sessionid", value[0]);
      await prefs.setString("ds_user_id", value[1]);

      flutterWebViewPlugin.close();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyTabView(),
        ),
      );
    });
  }

  Future<List<String>> getAllCookies(String url) async {
    final cookieManager = WebviewCookieManager();
    final cookies = await cookieManager.getCookies(url);
    List<String> data = [];
    String sessionId = "", ds_user_id = "";

    for(var item in cookies){
      if(item.name.contains("session")){
        // print(item.value);
        // print(item.name);
        sessionId = item.value;
      }
      if(item.name.contains("ds_user_id")){
        ds_user_id = item.value;
      }
    }

    data.add(sessionId);
    data.add(ds_user_id);

    return data;
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
