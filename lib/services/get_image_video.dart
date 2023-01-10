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

  var src;

  Future<String?> myImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString("sessionid");
    String? ds_user_id = prefs.getString("ds_user_id");

    print(sessionId);
    print(ds_user_id);

    String cdnLink = "";

    print("${"cookie:" "sessionid=$sessionId;ds_user_id=$ds_user_id"}");
    var url = instaposturl!;
    var response = await http.get(
      Uri.parse(url + "?__a=1&__d=dis"),
      headers: {"cookie": "sessionid=$sessionId;ds_user_id=$ds_user_id"},
    );

    // print(response.body.contains("video_url"));

    if (response.statusCode == 200) {
      src = json.decode(response.body);
      print(src["items"][0]);

      // print(src["items"][0]["image_versions2"]["candidates"][0]["url"]);
      if (src.containsKey("items")) {
        if (src["items"][0].containsKey("image_versions2")) {
          return src["items"][0]["image_versions2"]["candidates"][0]["url"];
        } else {
          return "private";
        }
        // if (src!.contains("video_versions")) {
        //   try {
        //     print("Yes video");
        //
        //     src = src!.substring(src!.indexOf("\"video_versions\":") + 17,
        //         src!.indexOf("\"has_audio\":") - 1);
        //     // src = src!.substring(src!.indexOf("https"), src!.length - 1);
        //     print(src);
        //     final data = jsonDecode(src!)[0]["url"];
        //     print("data:= $data");
        //     src = data;
        //
        //     var r = "\\u0026";
        //     // print(src);
        //     src = src!.replaceAll(r, "&");
        //   } catch (e) {
        //     print(e);
        //     return "private";
        //   }
        // } else {
        //   try {
        //     print("Yes image");
        //
        //     src = src!.substring(src!.indexOf("\"height\":750") + 18,
        //         src!.indexOf("\"width\":640"));
        //     src = src!.substring(src!.indexOf("https"), src!.length - 3);
        //     // print(src);
        //
        //     var r = "\\u0026";
        //     src = src!.replaceAll(r, "&");
        //   } catch (e) {
        //     print(e);
        //     return "private";
        //   }
        // }
      } else {
        return "private";
      }
    }

    return cdnLink;
  }

  Future<String?> myVideo() async {
    final prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString("sessionid");
    String? ds_user_id = prefs.getString("ds_user_id");

    String cdnLink = "";

    var url = instaposturl!;
    var response = await http.get(
      Uri.parse(url + "?__a=1&__d=dis"),
      headers: {"cookie": "sessionid=$sessionId;ds_user_id=$ds_user_id"},
    );

    // print(response.body.contains("video_url"));

    if (response.statusCode == 200) {
      src = json.decode(response.body);
      print(src["items"][0]);

      // print(src["items"][0]["image_versions2"]["candidates"][0]["url"]);
      if (src.containsKey("items")) {
        if (src["items"][0].containsKey("video_versions")) {
          return src["items"][0]["video_versions"][0]["url"];
        } else {
          return "private";
        }
        // if (src!.contains("video_versions")) {
        //   try {
        //     print("Yes video");
        //
        //     src = src!.substring(src!.indexOf("\"video_versions\":") + 17,
        //         src!.indexOf("\"has_audio\":") - 1);
        //     // src = src!.substring(src!.indexOf("https"), src!.length - 1);
        //     print(src);
        //     final data = jsonDecode(src!)[0]["url"];
        //     print("data:= $data");
        //     src = data;
        //
        //     var r = "\\u0026";
        //     // print(src);
        //     src = src!.replaceAll(r, "&");
        //   } catch (e) {
        //     print(e);
        //     return "private";
        //   }
        // } else {
        //   try {
        //     print("Yes image");
        //
        //     src = src!.substring(src!.indexOf("\"height\":750") + 18,
        //         src!.indexOf("\"width\":640"));
        //     src = src!.substring(src!.indexOf("https"), src!.length - 3);
        //     // print(src);
        //
        //     var r = "\\u0026";
        //     src = src!.replaceAll(r, "&");
        //   } catch (e) {
        //     print(e);
        //     return "private";
        //   }
        // }
      } else {
        return "private";
      }
    }

    return cdnLink;
  }
}
