/* MIT License

Copyright (c) 2020 Prince Sanjivy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sharestapp/my_tabview.dart';
import 'package:sharestapp/pages/about_us.dart';
import 'package:sharestapp/providers/show_lottie.dart';
import 'package:sharestapp/services/show_interstitial_ad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ['44C21CA2B517E5E19D6F9D510C330CA2']));
  FullScreenAd object = FullScreenAd();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ShowLottie(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final iconColor = Color(0xFFE84A5F);
    final appbarColor = Color(0xFFE84A5F);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.grey[800],
              ),
        ),
        primaryColor: appbarColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFE84A5F),
          titleTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.w600,
          ),
          // textTheme: GoogleFonts.quicksandTextTheme(
          //   Theme.of(context).textTheme.apply(
          //         bodyColor: Colors.white,
          //       ),
          // ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color?>(Colors.red[200]),
            // foregroundColor: MaterialStateProperty.all<Color>(appbarColor),
            backgroundColor: MaterialStateProperty.all<Color>(appbarColor),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color?>(Colors.red[200]),
            foregroundColor: MaterialStateProperty.all<Color>(appbarColor),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: iconColor,
        ),
      ),
      home: MyTabView(),
      routes: {
        '/aboutus': (context) => AboutUs(),
      },
    );
  }
}
