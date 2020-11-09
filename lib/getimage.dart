/**
 * @author Prince Sanjivy
 * @email sanjivy.android@gmail.com
 * @create date 2020-11-10 01:46:44
 * @modify date 2020-11-10 01:46:44
 */
import 'package:http/http.dart' as http;

class GetImageFromUrl {
  final String instaposturl;
  GetImageFromUrl(this.instaposturl);

  String src;

  Future<String> myimage() async {
    var url = instaposturl;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      src = response.body;
      src = src.substring(src.indexOf("\"config_width\":750"),
          src.indexOf("\"config_width\":1080"));
      src = src.substring(src.indexOf("https"), src.length - 2);
      var r = "\\u0026";
      src = src.replaceAll(r, "&");
    }

    return src;
  }
}
