/*
 * @author Prince Sanjivy
 * @email sanjivy.android@gmail.com
 * @create date 2020-11-10 01:46:44
 * @modify date 2020-11-10 01:46:44
 */
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetImageVideoFromUrl {
  final String instaposturl;
  GetImageVideoFromUrl(this.instaposturl);

  String src;

  Future<String> myImageVideo() async {
    final prefs = await SharedPreferences.getInstance();
    String sessionId = prefs.getString("sessionid");
    print(sessionId);

    var url = instaposturl;
    var response = await http.get(
      Uri.parse(url),
      headers: {"cookie": "sessionid=$sessionId"},
    );

    // print(response.body.contains("video_url"));

    if (response.statusCode == 200) {
      src = response.body;
      // print(src);

      if (src.contains("video_url")) {
        try {
          print("Yes video");

          src = src.substring(src.indexOf("\"video_url\":\""),
              src.indexOf("\",\"video_view_count\":"));
          var r = "\\u0026";
          print(src);
          src = src.replaceAll(r, "&");
          src = src.replaceAll("\"video_url\":\"", "");
        } catch (e) {
          print(e);
          return "private";
        }
      } else {
        try {
          print("Yes image");

          src = src.substring(src.indexOf("\"config_width\":750"),
              src.indexOf("\"config_width\":1080"));
          src = src.substring(src.indexOf("https"), src.length - 2);
          var r = "\\u0026";
          src = src.replaceAll(r, "&");
        } catch (e) {
          print(e);
          return "private";
        }
      }
    }

    return src;
  }
}
