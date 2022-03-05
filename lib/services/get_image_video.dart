/*
 * @author Prince Sanjivy
 * @email sanjivy.android@gmail.com
 * @create date 2020-11-10 01:46:44
 * @modify date 2020-11-10 01:46:44
 */
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetImageVideoFromUrl {
  final String? instaposturl;
  GetImageVideoFromUrl(this.instaposturl);

  String? src;

  Future<String?> myImageVideo() async {
    final prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString("sessionid");
    print(sessionId);

    var url = instaposturl!;
    var response = await http.get(
      Uri.parse(url),
      headers: {"cookie": "sessionid=$sessionId"},
    );

    // print(response.body.contains("video_url"));

    if (response.statusCode == 200) {
      src = response.body;
      // print(src);

      if (src!.contains("video_versions")) {
        try {
          print("Yes video");

          src = src!.substring(src!.indexOf("\"video_versions\":") + 17,
              src!.indexOf("\"has_audio\":") - 1);
          // src = src!.substring(src!.indexOf("https"), src!.length - 1);
          print(src);
          final data = jsonDecode(src!)[0]["url"];
          print("data:= $data");
          src = data;

          var r = "\\u0026";
          // print(src);
          src = src!.replaceAll(r, "&");
        } catch (e) {
          print(e);
          return "private";
        }
      } else {
        try {
          print("Yes image");

          src = src!.substring(src!.indexOf("\"height\":750") + 18,
              src!.indexOf("\"width\":640"));
          src = src!.substring(src!.indexOf("https"), src!.length - 3);
          // print(src);

          var r = "\\u0026";
          src = src!.replaceAll(r, "&");
        } catch (e) {
          print(e);
          return "private";
        }
      }
    }

    return src;
  }
}
