/**
 * @author Prince Sanjivy, Vignesh Hendrix
 * @email sanjivy.android@gmail.com, vigneshvicky8384@gmail.com
 * @create date 2020-11-10 01:47:05
 * @modify date 2020-11-10 01:47:05
 * @desc [description]
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharestapp/pages/login_instagram.dart';
import 'package:sharestapp/providers/show_lottie.dart';
import 'package:sharestapp/services/save_image.dart';
import 'package:sharestapp/services/share_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imageurl;
  String instaposturl;
  String _sharedText;
  StreamSubscription _intentDataStreamSubscription;
  String con =
      "Sharestapp is an open source application that let's an end user to directly share an image/video from Instagram to other apps in an exact image/video format, and also allows the user to save in mobile's local storage.";
  var f;
  var _controlText = "PLAY";
  int imagesshared = 0;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  VideoPlayerController _controller;
  Future<void> _videoPlayerFuture;
  bool showTap = false;

  @override
  void initState() {
    super.initState();

    _getShareCount().then((value) {
      setState(() {
        imagesshared = value;
      });
    });

    // _intentDataStreamSubscription =
    //     ReceiveSharingIntent.getTextStream().listen((String value) {
    //   showLoadingDialog(context, _keyLoader);
    //   setState(() {
    //     _sharedText = value;
    //     instaposturl = _sharedText;
    //     instaposturl = instaposturl.substring(
    //         instaposturl.indexOf("ttps://") - 1,
    //         instaposturl.indexOf("?utm"));

    //     print(instaposturl);
    //     GetImageVideoFromUrl(instaposturl).myImageVideo().then((value) {
    //       setState(() {
    //         print(value);
    //         _imageurl = value;

    //         _saveImagetoCache(_imageurl);
    //       });
    //     });
    //   });
    // }, onError: (err) {
    //   print("getLinkStream error: $err");
    // });

    // ReceiveSharingIntent.getInitialText().then((String value) {
    //   setState(() {
    //     _sharedText = value;
    //     if (_sharedText != null) {
    //       showLoadingDialog(context, _keyLoader);

    //       instaposturl = _sharedText;
    //       instaposturl = instaposturl.substring(
    //           instaposturl.indexOf("ttps://") - 1,
    //           instaposturl.indexOf("?utm"));

    //       print(instaposturl);
    //       GetImageVideoFromUrl(instaposturl).myImageVideo().then((value) {
    //         setState(() {
    //           print(value);
    //           _imageurl = value;

    //           _saveImagetoCache(_imageurl);
    //         });
    //       });
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // _intentDataStreamSubscription.cancel();
    if (_controller != null) _controller.dispose();
    // setState(() {
    //   _sharedText = null;
    // });
    ReceiveSharingIntent.reset();
  }

  _saveImagetoCache(i) async {
    if (_imageurl != null) {
      var myFile = await DefaultCacheManager().downloadFile(i);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      setState(() {
        _sharedText = null;
        ReceiveSharingIntent.reset();
        f = myFile;

        if (f.file.path.toString().endsWith("jpg")) {
          print(f.file.path);
          _showImageDialog(f);
        } else {
          print(f.file.path);

          _controller = VideoPlayerController.file(f.file);
          _videoPlayerFuture = _controller.initialize();
          _controller.setLooping(true);
          _controller.play();

          _showVideoDialog(f);
        }
      });
    }
  }

  void _showImageDialog(var file) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Share to WhatsApp"),
          content: Image.file(file.file),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                SaveImageToDir(file.file).saveImageToDir();
                Navigator.of(context).pop();
              },
              child: Text("SAVE"),
            ),
            TextButton(
              child: Text("SHARE"),
              onPressed: () {
                _setShareCount();
                ShareImage(file.file.path).shareImage();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("CLOSE"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVideoDialog(var file) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Share post to"),
          content: FutureBuilder(
            future: _videoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: VideoPlayer(_controller),
                    ),
                  ],
                );
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text("SHARE"),
              onPressed: () {
                _setShareCount();
                ShareImage(file.file.path).shareImage();
                _controller.pause();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("CLOSE"),
              onPressed: () {
                _controller.pause();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              key: key,
              title: Text("Please wait"),
              content: Center(
                child: CircularProgressIndicator(),
                heightFactor: 1 / 2.5,
              ),
            ),
          );
        });
  }

  Future<int> _getShareCount() async {
    final prefs = await SharedPreferences.getInstance();
    int sharedCount = prefs.getInt("imagesshared");
    if (sharedCount == null) {
      return 0;
    } else {
      return sharedCount;
    }
  }

  _setShareCount() async {
    final prefs = await SharedPreferences.getInstance();
    int sharedCount = prefs.getInt("imagesshared");
    if (sharedCount == null) {
      prefs.setInt("imagesshared", 1);
    } else {
      prefs.setInt("imagesshared", sharedCount + 1);
      // print(sharedCount);
    }
  }

  // Stream<bool> getShow() async* {
  //   final prefs = await SharedPreferences.getInstance();
  //   print(prefs.getBool("show").toString());
  //   yield prefs.getBool("show");
  // }

  @override
  Widget build(BuildContext context) {
    final textColor = Color(0xFFE84A5F);
    return SingleChildScrollView(
      child: Consumer<ShowLottie>(builder: (context, show, _) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            show.getValue()
                ? Positioned(
                    bottom: 5,
                    right: 5,
                    child: Lottie.asset(
                      "assets/hand_tap.json",
                      width: 180,
                      height: 180,
                    ),
                  )
                : Container(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                    // bottom: 10,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey[200],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          con,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14.5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashColor: Colors.red[200],
                                highlightColor: Colors.red[200],
                                borderRadius: BorderRadius.circular(30.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      size: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Rate & Review",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  launch(
                                      "https://play.google.com/store/apps/details?id=com.princeappstudio.sharestapp");
                                },
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    splashRadius: 30,
                                    splashColor: Colors.red[200],
                                    highlightColor: Colors.red[200],
                                    icon: Icon(
                                      FontAwesomeIcons.github,
                                    ),
                                    onPressed: () {
                                      launch(
                                          "https://github.com/princesanjivy/sharestapp");
                                    },
                                  ),
                                  IconButton(
                                    splashRadius: 30,
                                    splashColor: Colors.red[200],
                                    highlightColor: Colors.red[200],
                                    icon: Icon(
                                      Icons.share,
                                    ),
                                    onPressed: () {
                                      ShareText("Check out this cool app \"Sharestapp\" !" +
                                              "https://play.google.com/store/apps/details?id=com.princeappstudio.sharestapp")
                                          .send();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                top: 10,
                                left: 10,
                                right: 5,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await launch(
                                      "https://play.google.com/store/apps/dev?id=6439925551269057866");
                                },
                                borderRadius: BorderRadius.circular(10),
                                highlightColor: Colors.red[200],
                                splashColor: Colors.red[200],
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          2,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey[200],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.shopping_cart,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              "More Apps",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "Check other apps published on Google Play Store",
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                top: 5,
                                left: 10,
                                right: 5,
                              ),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Clear cache"),
                                          content: Text(
                                              "Do you want to clear the app cache memory?"),
                                          actions: [
                                            TextButton(
                                              child: Text("YES"),
                                              onPressed: () {
                                                DefaultCacheManager()
                                                    .emptyCache();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text("NO"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                borderRadius: BorderRadius.circular(10),
                                highlightColor: Colors.red[200],
                                splashColor: Colors.red[200],
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          2,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey[200],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.cached,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Clear Cache",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "Remove your app cache",
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                                top: 5,
                                left: 10,
                                right: 5,
                              ),
                              child: InkWell(
                                onTap: () {
                                  showAboutDialog(
                                    context: context,
                                    applicationName: "Sharestapp",
                                    applicationVersion: "1.0.0",
                                    applicationIcon: Container(
                                      height: 45,
                                      child: Image.asset("assets/icon.png"),
                                    ),
                                    // children: [
                                    //   Container(
                                    //     height: 50,
                                    //     child: Image.asset("assets/icon.png"),
                                    //   ),
                                    // ],
                                    applicationLegalese:
                                        "I'll make it simple!", // Its app's tagline
                                  );
                                },
                                borderRadius: BorderRadius.circular(10),
                                highlightColor: Colors.red[200],
                                splashColor: Colors.red[200],
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          2,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey[200],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              "About",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "More info about Sharestapp",
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                top: 10,
                                left: 5,
                                right: 10,
                              ),
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width - 30) /
                                        2,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey[200],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          imagesshared.toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 70,
                                            color: textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Contents shared"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                top: 5,
                                left: 5,
                                right: 10,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // Timer(Duration(milliseconds: 200), () {
                                  Navigator.pushNamed(context, "/aboutus");
                                  // Navigator.push(
                                  // context, FadeRoute(page: AboutUs()));
                                  // });
                                },
                                borderRadius: BorderRadius.circular(10),
                                highlightColor: Colors.red[200],
                                splashColor: Colors.red[200],
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          2,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey[200],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.code,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              "Developers",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "Click to know about the developers",
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            /// Login to Insta Container
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                top: 5,
                                left: 5,
                                right: 10,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  // final prefs =
                                  //     await SharedPreferences.getInstance();
                                  // await prefs.setBool("show", false);

                                  Provider.of<ShowLottie>(context,
                                          listen: false)
                                      .setValue(false);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InstaLogin(),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(10),
                                highlightColor: Colors.red[200],
                                splashColor: Colors.red[200],
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          2,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey[200],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.login,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "Login to Instagram inorder to share or save contents",
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
