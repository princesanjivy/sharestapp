import 'package:sharestapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharestapp/wastatuspage.dart';

class MyTabView extends StatefulWidget {
  @override
  _MyTabViewState createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sharestapp',
            style: GoogleFonts.aBeeZee(
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.blueAccent,
          elevation: 2.0,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Whatsapp Status',
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [MyHomePage(), MyWAStatusPage()],
        ),
      ),
    );
  }
}
