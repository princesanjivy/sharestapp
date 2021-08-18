/*
 * @author Vignesh Hendrix
 * @email vigneshvicky8384@gmail.com,
 * @create date 2020-11-10 01:44:06
 * @modify date 2020-11-10 01:44:06
 */
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void redirect(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    print('Sorry,could not launch $url');
  }
}

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Developers',
        ),
        // elevation: 5.0,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                ),
                child: Center(
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/sanjivy.jpg',
                      ),
                      backgroundColor: Colors.white,
                      radius: 65.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  'Prince Sanjivy',
                  style: GoogleFonts.quicksand(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE84A5F),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 15.0,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                      fontSize: 13.0,
                      color: Colors.grey[800],
                    ),
                    children: [
                      TextSpan(
                        text: '"A passionate coder in ',
                      ),
                      TextSpan(
                        text: 'Python ',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.red[200],
                        ),
                      ),
                      TextSpan(
                        text:
                            ' who loves to build apps and games for Android and Web."',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 13.0,
                  right: 13.0,
                  top: 13.0,
                ),
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        redirect('https://github.com/princesanjivy');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        size: 25.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.red[200],
                      highlightColor: Colors.red[200],
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('https://www.facebook.com/PrinceSanjivy');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 25.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.red[200],
                      highlightColor: Colors.red[200],
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('https://www.instagram.com/princesanjivy/');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 25.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.red[200],
                      highlightColor: Colors.red[200],
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('https://princesanjivy-portfolio.web.app/');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.globeAsia,
                        size: 25.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.red[200],
                      highlightColor: Colors.red[200],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                ),
                child: Center(
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/vignesh.jpeg',
                      ),
                      backgroundColor: Colors.white,
                      radius: 65.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  'Vignesh Hendrix',
                  style: GoogleFonts.quicksand(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE84A5F),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 15.0,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                      fontSize: 13.0,
                      color: Colors.grey[800],
                    ),
                    children: [
                      TextSpan(
                        text: '"An intermediate level competitive programmer',
                      ),
                      TextSpan(
                        text: ', Problem solver, and a Front end Developer."',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 13.0,
                  right: 13.0,
                  top: 13.0,
                ),
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        redirect('https://github.com/VigneshHendrix');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        size: 25.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.red[200],
                      highlightColor: Colors.red[200],
                    ),
                    IconButton(
                      onPressed: () {
                        redirect(
                            'https://www.facebook.com/profile.php?id=100012796634175');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 25.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.red[200],
                      highlightColor: Colors.red[200],
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('https://www.instagram.com/vignesh_hendrix/');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 25.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.red[200],
                      highlightColor: Colors.red[200],
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('https://vigneshhendrix.github.io/');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.globeAsia,
                        size: 25.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.red[200],
                      highlightColor: Colors.red[200],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
