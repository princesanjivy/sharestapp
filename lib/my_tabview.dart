/*
 * @author Vignesh Hendrix, Prince Sanjivy
 * @email vigneshvicky8384@gmail.com, sanjivy.android@gmail.com
 * @create date 2020-11-10 01:47:53
 * @modify date 2020-11-10 01:47:53
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharestapp/pages/home.dart';
import 'package:sharestapp/pages/saved_images.dart';
import 'package:sharestapp/pages/saved_videos.dart';
import 'package:sharestapp/providers/show_lottie.dart';
import 'package:sharestapp/services/get_image_video.dart';
import 'package:sharestapp/services/save_image.dart';
import 'package:sharestapp/services/share_image.dart';
import 'package:sharestapp/services/show_interstitial_ad.dart';
import 'package:video_player/video_player.dart';

class MyTabView extends StatefulWidget {
  @override
  _MyTabViewState createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  String? _imageurl;
  String? instaposturl;
  String? _sharedText, sessionId;
  BannerAd? myBanner;

  var permission = Permission.storage;
  bool permissionStatus = false;
  late StreamSubscription _intentDataStreamSubscription;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  VideoPlayerController? _controller;
  Future<void>? _videoPlayerFuture;
  var f;

  @override
  void initState() {
    super.initState();

    _initBannerAd();
    requestPermission();

    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      print(sessionId);
      print("URL: $value");
      if (value != null) {
        if (sessionId != null) {
          print("Insta: $value");
          if (value.contains("?igshid") &&
              value.contains("www.instagram.com/p/")) {
            setState(() {
              _sharedText = value;
              if (_sharedText != null) {
                showLoadingDialog(context, _keyLoader);

                instaposturl = _sharedText;
                instaposturl = instaposturl!.substring(
                    instaposturl!.indexOf("https://"),
                    instaposturl!.indexOf("?igshid"));

                print(instaposturl);
                GetImageVideoFromUrl(instaposturl).myImage().then((value) {
                  setState(() {
                    print(value);
                    _imageurl = value;

                    if (_imageurl != null && _imageurl != "private")
                      _saveImagetoCache(_imageurl);
                    else {
                      print("Its private");
                      _itsPrivate();
                    }
                  });
                });
              }
            });
          } else if (value.contains("?igshid") &&
              value.contains("www.instagram.com/reel/")) {
            setState(() {
              _sharedText = value;
              if (_sharedText != null) {
                showLoadingDialog(context, _keyLoader);

                instaposturl = _sharedText;
                instaposturl = instaposturl!.substring(
                    instaposturl!.indexOf("https://"),
                    instaposturl!.indexOf("?igshid"));

                print(instaposturl);
                GetImageVideoFromUrl(instaposturl).myVideo().then((value) {
                  setState(() {
                    print(value);
                    _imageurl = value;

                    if (_imageurl != null && _imageurl != "private")
                      _saveImagetoCache(_imageurl);
                    else {
                      print("Its private");
                      _itsPrivate();
                    }
                  });
                });
              }
            });
          }
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Please login to Instagram"),
                    content: ElevatedButton(
                      onPressed: () async {
                        Provider.of<ShowLottie>(context, listen: false)
                            .setValue(true);

                        Navigator.pop(context);
                      },
                      child: Text("Login"),
                    ),
                  ));
        }
      }
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    ReceiveSharingIntent.getInitialText().then((String? value) {
      print(sessionId);
      print("URL: $value");
      if (value != null) {
        if (sessionId != null) {
          if (value.contains("?igshid") &&
              value.contains("www.instagram.com/p/")) {
            setState(() {
              _sharedText = value;
              if (_sharedText != null) {
                showLoadingDialog(context, _keyLoader);

                instaposturl = _sharedText;
                instaposturl = instaposturl!.substring(
                    instaposturl!.indexOf("https://"),
                    instaposturl!.indexOf("?igshid"));

                print(instaposturl);
                GetImageVideoFromUrl(instaposturl).myImage().then((value) {
                  setState(() {
                    print(value);
                    _imageurl = value;

                    if (_imageurl != null && _imageurl != "private")
                      _saveImagetoCache(_imageurl);
                    else {
                      print("Its private");
                      _itsPrivate();
                    }
                  });
                });
              }
            });
          } else if (value.contains("?igshid") &&
              value.contains("www.instagram.com/reel/")) {
            setState(() {
              _sharedText = value;
              if (_sharedText != null) {
                showLoadingDialog(context, _keyLoader);

                instaposturl = _sharedText;
                instaposturl = instaposturl!.substring(
                    instaposturl!.indexOf("https://"),
                    instaposturl!.indexOf("?igshid"));

                print(instaposturl);
                GetImageVideoFromUrl(instaposturl).myVideo().then((value) {
                  setState(() {
                    print(value);
                    _imageurl = value;

                    if (_imageurl != null && _imageurl != "private")
                      _saveImagetoCache(_imageurl);
                    else {
                      print("Its private");
                      _itsPrivate();
                    }
                  });
                });
              }
            });
          }
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Please login to Instagram"),
                    content: ElevatedButton(
                      onPressed: () async {
                        Provider.of<ShowLottie>(context, listen: false)
                            .setValue(true);

                        Navigator.pop(context);
                      },
                      child: Text("Login"),
                    ),
                  ));
        }
      }
    });
  }

  _initBannerAd() {
    myBanner = BannerAd(
      adUnitId: "ca-app-pub-5164932036098856/9529329481",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );

    myBanner!.load();
  }

  _itsPrivate() {
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(
                "You cannot share posts from a private Instagram account."),
            actions: [
              TextButton(
                child: Text("CLOSE"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _setShareCount() async {
    final prefs = await SharedPreferences.getInstance();
    int? sharedCount = prefs.getInt("imagesshared");
    if (sharedCount == null) {
      prefs.setInt("imagesshared", 1);
    } else {
      prefs.setInt("imagesshared", sharedCount + 1);
      // print(sharedCount);
    }
  }

  _saveImagetoCache(i) async {
    if (_imageurl != null) {
      var myFile = await DefaultCacheManager().downloadFile(i);
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
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
          _videoPlayerFuture = _controller!.initialize();
          _controller!.setLooping(true);
          _controller!.play();

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
          title: Text("Share post to"),
          content: Image.file(file.file),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                SaveImageToDir(file.file).saveImageToDir();
                // InterstitialAd().showAd();
                FullScreenAd.object.show();
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
                // InterstitialAd().showAd();
                FullScreenAd.object.show();
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
                      child: VideoPlayer(_controller!),
                    ),
                  ],
                );
              else
                return SizedBox(
                  height: 80,
                  child: Center(child: CircularProgressIndicator()),
                );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                SaveImageToDir(file.file).saveVideoToDir();
                // InterstitialAd().showAd();
                FullScreenAd.object.show();
                _controller!.pause();
                Navigator.of(context).pop();
              },
              child: Text("SAVE"),
            ),
            TextButton(
              child: Text("SHARE"),
              onPressed: () {
                _setShareCount();
                ShareImage(file.file.path).shareImage();
                _controller!.pause();
                // // InterstitialAd().showAd();
                FullScreenAd.object.show();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("CLOSE"),
              onPressed: () {
                _controller!.pause();
                // InterstitialAd().showAd();
                FullScreenAd.object.show();
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

  @override
  void dispose() {
    super.dispose();
    _intentDataStreamSubscription.cancel();
    ReceiveSharingIntent.reset();
    if (_controller != null) _controller!.dispose();
  }

  void requestPermission() async {
    final prefs = await SharedPreferences.getInstance();
    sessionId = prefs.getString("sessionid");

    if (await permission.request().isGranted) {
      print("Granted");
      setState(() {
        permissionStatus = true;
      });
    } else {
      print("Denied");
      setState(() {
        permissionStatus = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: myBanner!);

    return !permissionStatus
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Sharestapp',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Please give storage permission!"),
                  ElevatedButton(
                    onPressed: () async {
                      if (await permission.isPermanentlyDenied) {
                        openAppSettings();
                        // showDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     builder: (BuildContext context) {
                        //       return
                        //     });
                      } else {
                        requestPermission();
                      }
                    },
                    child: Text("Request permission"),
                  ),
                ],
              ),
            ),
          )
        : DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Sharestapp',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                elevation: 3.0,
                bottom:
                    // PreferredSize(
                    //     preferredSize: Size(double.infinity, 50),
                    //     child: SingleChildScrollView(
                    //       scrollDirection: Axis.horizontal,
                    //       child: Row(
                    //         children: [
                    //           TabBar(
                    //             isScrollable: true,
                    //             tabs: [
                    //               Tab(text: "HOME"),
                    //               Tab(text: "WHATSAPP STATUS"),
                    //               Tab(text: "SAVED IMAGES"),
                    //               Tab(text: "SAVED VIDEOS"),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     )),
                    TabBar(
                  // isScrollable: true,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      // text: 'HOME',
                      icon: Icon(Icons.home_outlined),
                    ),
                    // Tab(
                    //   text: 'WHATSAPP STATUS',
                    //   // icon: Icon(Icons.ac_unit),
                    // ),
                    Tab(
                      text: 'IMAGES',
                      // icon: Icon(Icons.ac_unit),
                    ),
                    Tab(
                      text: 'VIDEOS',
                      // icon: Icon(Icons.ac_unit),
                    ),
                  ],
                ),
              ),
              // drawer: SideMenu(),
              body: TabBarView(
                children: [
                  MyHomePage(),
                  // MyWAStatusPage(),
                  MySharestappPage(),
                  SavedVideoPage(),
                ],
              ),
              bottomNavigationBar: Container(
                alignment: Alignment.center,
                child: adWidget,
                width: myBanner!.size.width.toDouble(),
                height: myBanner!.size.height.toDouble(),
              ),
            ),
          );
  }
}
