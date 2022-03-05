/*
 * @author Prince Sanjivy, Vignesh Hendrix
 * @email sanjivy.android@gmail.com, vigneshvicky8384@gmail.com
 * @create date 2020-11-10 01:49:28
 * @modify date 2020-11-10 01:49:28
 */
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as i;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharestapp/components/fullscreen_view.dart';
import 'package:sharestapp/services/ads.dart';
import 'package:sharestapp/services/save_image.dart';
import 'package:sharestapp/services/share_image.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MyWAStatusPage extends StatefulWidget {
  const MyWAStatusPage({Key? key}) : super(key: key);

  @override
  _MyWAStatusPageState createState() => _MyWAStatusPageState();
}

class _MyWAStatusPageState extends State<MyWAStatusPage> {
  List files = new List.empty(growable: true);
  List<File> loadedImageThumbnailsFile = [];

  bool dirExists = false;
  bool isDataLoaded = false;

  // AdmobInterstitial interstitialAd;
  // var wa_path = "/storage/emulated/0/Pictures/Demo";
  var wa_path = "/storage/emulated/0/WhatsApp/Media/.Statuses";
  // VideoPlayerController _controller;
  BetterPlayerController? betterPlayerController;

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

  @override
  void initState() {
    super.initState();

    // interstitialAd = AdmobInterstitial(
    //   adUnitId: "ca-app-pub-3940256099942544/1033173712",
    //   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
    //     if (event == AdmobAdEvent.closed) {
    //       interstitialAd.load();
    //     }
    //   },
    // );
    _checkDirExists();
  }

  // Future<File> thumbnail(file) async {
  //   var cacheDir = await getTemporaryDirectory();
  //   var path = file.path;
  //   path = path.substring(path.lastIndexOf("/"), path.length);

  //   Uint8List bytes = await VideoThumbnail.thumbnailData(
  //       video: file.path, imageFormat: ImageFormat.PNG);
  //   return File("${cacheDir.path}$path")..writeAsBytesSync(bytes);
  // }

  _checkDirExists() async {
    bool exists = await Directory(wa_path).exists();

    print(exists);

    print(Directory(wa_path).listSync());

    if (exists) {
      files = Directory(wa_path)
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg") || item.endsWith(".mp4"))
          // .where((element) => element.endsWith(".jpg"))
          .toList();
      setState(() {
        isDataLoaded = false;
      });

      loadFiles(files);

      setState(() {
        dirExists = true;
      });
    } else {
      setState(() {
        dirExists = false;
      });
    }
  }

  void loadFiles(List files) async {
    for (String f in files as Iterable<String>) {
      File file = File(f);

      if (file.path.endsWith(".mp4")) {
        String tempFilePath = await (VideoThumbnail.thumbnailFile(
          video: file.path.toString(),
          quality: 98,
        ) as FutureOr<String>);
        print(tempFilePath);

        File tempFile = File(tempFilePath);
        loadedImageThumbnailsFile.add(tempFile);
      } else {
        loadedImageThumbnailsFile.add(file);
      }
    }

    print(loadedImageThumbnailsFile.length);
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (betterPlayerController != null) betterPlayerController!.dispose();

    isDataLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return !dirExists
        ? Center(child: Text("WhatsApp is not installed!"))
        : !isDataLoaded
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 4),
                  Text("Loading files..."),
                ],
              ))
            : GridView.builder(
                itemCount: files.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 3),
                itemBuilder: (context, index) {
                  File myfile = new File(files[index]);
                  // File thumbnailFile;

                  // String thumbData = await VideoThumbnail.thumbnailFile(
                  //   video: myfile.path.toString(),
                  //   quality: 98,
                  // );

                  // _controller = VideoPlayerController.file(myfile)
                  //   ..initialize().then((value) {
                  //     setState(() {});
                  // });
                  // _controller.setLooping(false);
                  // _controller.setVolume(0);
                  // if (myfile.path.endsWith(".mp4")) {
                  //   thumbnail(myfile).then((value) => thumbnailFile = value);
                  // }
                  // if (myfile.path.endsWith(".mp4")) {
                  //   betterPlayerController = BetterPlayerController(
                  //       BetterPlayerConfiguration(
                  //         startAt: Duration(seconds: 10),
                  //         autoPlay: false,
                  //         aspectRatio: 0.85,
                  //         fit: BoxFit.cover,
                  //         controlsConfiguration: BetterPlayerControlsConfiguration(
                  //           showControls: false,
                  //           enableMute: false,
                  //           enableFullscreen: false,
                  //           enableSkips: false,
                  //           enableOverflowMenu: false,
                  //           enablePlayPause: false,
                  //           enableProgressBar: false,
                  //         ),
                  //       ),
                  //       betterPlayerDataSource:
                  //           BetterPlayerDataSource.file(myfile.path));
                  //   betterPlayerController.setVolume(1);
                  // }

                  return GestureDetector(
                    onTap: () {
                      if (myfile.path.endsWith(".jpg"))
                        _showImageDialog(myfile);
                      else {
                        // _controller = VideoPlayerController.file(myfile)
                        //   ..initialize().then((value) {
                        //     setState(() {});
                        //   });
                        // _controller.setLooping(false);
                        // _controller.play();

                        _showVideoDialog(
                            myfile, loadedImageThumbnailsFile[index]);
                      }
                    },
                    child: Card(
                      elevation: 4,
                      child: GridTile(
                        child: myfile.path.endsWith(".jpg")
                            ? Hero(
                                tag: "image" + myfile.path.toString(),
                                child: Image.file(
                                  loadedImageThumbnailsFile[index],
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.file(
                                loadedImageThumbnailsFile[index],
                                fit: BoxFit.cover,
                              ),
                        // : BetterPlayer(
                        //     controller: betterPlayerController,
                        //   ),
                        // : VideoPlayer(_controller),
                        footer: Container(
                          color: Colors.white30,
                          alignment: Alignment.centerRight,
                          // padding: EdgeInsets.all(2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                type: MaterialType.transparency,
                                child: IconButton(
                                  splashRadius: 20,
                                  splashColor: Colors.red[200],
                                  highlightColor: Colors.red[200],
                                  icon: Icon(
                                    Icons.share,
                                  ),
                                  onPressed: () async {
                                    _setShareCount();
                                    var cacheDir =
                                        await getTemporaryDirectory();
                                    File f;
                                    var path = myfile.path;
                                    path = path.substring(
                                        path.lastIndexOf("/"), path.length);

                                    print(path);

                                    if (myfile.path.endsWith(".jpg")) {
                                      i.Image image = i.decodeImage(
                                          myfile.readAsBytesSync())!;

                                      f = File("${cacheDir.path}$path")
                                        ..writeAsBytesSync(i.encodeJpg(image));
                                      print(f);
                                    } else {
                                      Uint8List bytes =
                                          myfile.readAsBytesSync();
                                      f = File("${cacheDir.path}$path")
                                        ..writeAsBytesSync(bytes);
                                      print(f);
                                    }

                                    ShareImage(f.path).shareImage();
                                    InterstitialAd().showAd();
                                  },
                                ),
                              ),
                              Material(
                                type: MaterialType.transparency,
                                child: IconButton(
                                  splashRadius: 20,
                                  splashColor: Colors.red[200],
                                  highlightColor: Colors.red[200],
                                  icon: Icon(
                                    Icons.save_alt,
                                  ),
                                  onPressed: () async {
                                    // _controller.play();
                                    myfile.path.endsWith(".jpg")
                                        ? SaveImageToDir(myfile)
                                            .saveImageToDir()
                                        : SaveImageToDir(myfile)
                                            .saveVideoToDir();
                                    InterstitialAd().showAd();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
  }

  _showImageDialog(File file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenView(
          title: "Status Image",
          child: Hero(
            tag: "image" + file.path.toString(),
            child: Image.file(file),
          ),
        ),
      ),
    );

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text("Status Image"),
    //       content: Container(
    //         color: Colors.black,
    //         width: 250,
    //         height: 250,
    //         child: Image.file(file),
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text("CLOSE"),
    //         )
    //       ],
    //     );
    //   },
    // );
  }

  _showVideoDialog(File file, File videoThumbnail) async {
    final data = await decodeImageFromList(videoThumbnail.readAsBytesSync());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenView(
          title: "Status Video",
          child: BetterPlayer.file(
            file.path,
            betterPlayerConfiguration: BetterPlayerConfiguration(
              autoPlay: true,
              aspectRatio: data.width < data.height ? 9 / 16 : 16 / 9,
              fit: BoxFit.contain,
              controlsConfiguration: BetterPlayerControlsConfiguration(
                enableMute: false,
                enableFullscreen: false,
                enableSkips: false,
                enableOverflowMenu: false,
              ),
            ),
          ),
        ),
      ),
    );

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text("Status Video"),
    //       content: Container(
    //         // color: Colors.black,
    //         width: 250,
    //         height: 250,
    //         // child: VideoPlayer(_controller),
    //         child: BetterPlayer.file(
    //           file.path,
    //           betterPlayerConfiguration: BetterPlayerConfiguration(
    //             autoPlay: true,
    //             aspectRatio: 0.85,
    //             fit: BoxFit.cover,
    //             controlsConfiguration: BetterPlayerControlsConfiguration(
    //               enableMute: false,
    //               enableFullscreen: false,
    //               enableSkips: false,
    //               enableOverflowMenu: false,
    //             ),
    //           ),
    //         ),
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             // _controller.pause();
    //             // _controller.dispose();
    //             Navigator.pop(context);
    //           },
    //           child: Text("CLOSE"),
    //         )
    //       ],
    //     );
    //   },
    // );
  }
}
