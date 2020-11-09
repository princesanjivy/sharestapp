/**
 * @author Vignesh Hendrix
 * @email sanjivy.android@gmail.com
 * @create date 2020-11-10 01:44:06
 * @modify date 2020-11-10 01:44:06
 * @desc [description]
 */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharestapp/font_awesome_icons.dart';
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

void _launchMail(String email) async {
  if (await canLaunch("mailto:$email")) {
    await launch("mailto:$email");
  } else {
    print('Could not launch');
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Developers',
          style: GoogleFonts.actor(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 5.0,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/sanjivy.jpg',
                    ),
                    radius: 65.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Prince Sanjivy',
                style: GoogleFonts.raleway(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '"A Passionate Coder in ',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Python ',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                          fontSize: 16.0,
                        ),
                      ),
                      TextSpan(
                        text:
                            'who loves to build apps and games for Android and Web."',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      redirect('https://github.com/princesanjivy');
                    },
                    icon: Icon(
                      FontAwesome.github_circled,
                      size: 30.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      redirect('https://www.facebook.com/PrinceSanjivy');
                    },
                    icon: Icon(
                      FontAwesome.facebook_official,
                      size: 28.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      _launchMail('sanjivy.android@gmail.com');
                    },
                    icon: Icon(
                      FontAwesome.mail,
                      size: 28.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      redirect('https://www.instagram.com/princesanjivy/');
                    },
                    icon: Icon(
                      FontAwesome.instagram,
                      size: 28.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      redirect('https://princesanjivy.github.io/portfolio/');
                    },
                    icon: Icon(
                      FontAwesome.globe,
                      size: 30.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/vignesh.jpeg',
                    ),
                    radius: 65.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Vignesh Hendrix',
                style: GoogleFonts.raleway(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '"An Intermediate level Competitive Programmer in ',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 16.0, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'C++',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: ',Problem Solver, and a Front End developer."',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      redirect('https://github.com/VigneshHendrix');
                    },
                    icon: Icon(
                      FontAwesome.github_circled,
                      size: 30.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      redirect(
                          'https://www.facebook.com/profile.php?id=100012796634175');
                    },
                    icon: Icon(
                      FontAwesome.facebook_official,
                      size: 28.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      _launchMail('vigneshvicky8384@gmail.com');
                    },
                    icon: Icon(
                      FontAwesome.mail,
                      size: 28.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      redirect('https://www.instagram.com/vignesh_hendrix/');
                    },
                    icon: Icon(
                      FontAwesome.instagram,
                      size: 28.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      redirect(
                          'https://www.linkedin.com/in/vignesh-k-53a0651b1/');
                    },
                    icon: Icon(
                      FontAwesome.linkedin_squared,
                      size: 28.0,
                    ),
                    splashColor: Colors.blue,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
