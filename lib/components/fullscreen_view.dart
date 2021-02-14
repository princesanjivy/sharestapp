import 'package:flutter/material.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';

class FullScreenView extends StatefulWidget {
  final String title;
  final Widget child;

  FullScreenView({
    this.title,
    @required this.child,
  });

  @override
  _FullScreenViewState createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: GestureZoomBox(
            maxScale: 6,
            doubleTapScale: 2,
            duration: Duration(milliseconds: 120),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
