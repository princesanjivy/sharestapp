/* 
 * @author Prince Sanjivy
 * @email sanjivy.android@gmail.com
 * @create date 2020-11-10 01:48:26
 * @modify date 2020-11-10 01:48:26
 */
import 'dart:io';
import 'dart:typed_data';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharestapp/components/fullscreen_view.dart';
import 'package:sharestapp/services/ads.dart';
import 'package:sharestapp/services/share_image.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SavedVideoPage extends StatefulWidget {
  const SavedVideoPage({Key key}) : super(key: key);

  @override
  _SavedVideoPageState createState() => _SavedVideoPageState();
}

class _SavedVideoPageState extends State<SavedVideoPage> {
  List files = new List();
  List<File> loadedImageThumbnailsFile = [];

  bool _notcreated = true;
  bool isDataLoaded = false;

  BetterPlayerController betterPlayerController;

  var show;
  var _savedpath = "/storage/emulated/0/Videos/Sharestapp";

  @override
  void initState() {
    super.initState();

    _checkDirExists();
  }

  _checkDirExists() async {
    bool exists = await Directory(_savedpath).exists();

    if (exists) {
      print("Exists");
      if (this.mounted)
        setState(() {
          files = Directory(_savedpath)
              .listSync()
              .map((item) => item.path)
              .where((item) => item.endsWith(".mp4"))
              .toList();

          setState(() {
            isDataLoaded = false;
          });

          loadFiles(files);
          show = files.length;

          if (show != 0) {
            _notcreated = !_notcreated;
          }
        });
    } else {
      print("Nope");
      if (this.mounted) setState(() {});
    }
  }

  void loadFiles(List files) async {
    for (String f in files) {
      File file = File(f);

      if (file.path.endsWith(".mp4")) {
        String tempFilePath = await VideoThumbnail.thumbnailFile(
          video: file.path.toString(),
          quality: 98,
        );
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

  @override
  void dispose() {
    super.dispose();
    if (betterPlayerController != null) betterPlayerController.dispose();

    isDataLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return _notcreated
        ? Center(
            child: Text("No videos yet saved!"),
          )
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
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 3.0),
                itemBuilder: (context, index) {
                  File myfile = new File(files[index]);

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
                      _showVideoDialog(
                          myfile, loadedImageThumbnailsFile[index]);
                    },
                    child: Card(
                      elevation: 4,
                      child: GridTile(
                        child: Image.file(
                          loadedImageThumbnailsFile[index],
                          fit: BoxFit.cover,
                        ),
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

                                    var path = myfile.path;
                                    path = path.substring(
                                        path.lastIndexOf("/"), path.length);

                                    Uint8List bytes = myfile.readAsBytesSync();
                                    var f = File("${cacheDir.path}$path")
                                      ..writeAsBytesSync(bytes);
                                    print(f);

                                    ShareImage(f.path).shareImage();
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

  _showVideoDialog(File file, File videoThumbnail) async {
    final data = await decodeImageFromList(videoThumbnail.readAsBytesSync());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenView(
          title: "Saved Video",
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
  }
}
