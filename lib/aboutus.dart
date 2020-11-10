/*
 * @author Vignesh Hendrix
 * @email sanjivy.android@gmail.com
 * @email vigneshvicky8384@gmail.com,
 * @create date 2020-11-10 01:44:06
 * @modify date 2020-11-10 01:44:06
 * @desc [description]
 */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      appBar: AppBar(
        title: Text(
          'Developers',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 5.0,
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
                      radius: 70.0,
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
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
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
                      color: Colors.black,
                      fontSize: 13.0,
                    ),
                    children: [
                      TextSpan(
                        text: '"A passionate coder in ',
                      ),
                      TextSpan(
                        text: 'Python ',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
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
                        size: 30.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('https://www.facebook.com/PrinceSanjivy');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 30.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('sanjivy.android@gmail.com');
                      },
                      icon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey[700],
                        size: 35.0,
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        _launchMail('https://www.instagram.com/princesanjivy/');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 30.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('https://princesanjivy.github.io/portfolio/');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.globeAmericas,
                        size: 30.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
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
                      radius: 70.0,
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
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
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
                      color: Colors.black,
                      fontSize: 13.0,
                    ),
                    children: [
                      TextSpan(
                        text: '"An Intermediate level Competitive Programmer',
                      ),
                      TextSpan(
                        text: ',Problem Solver, and a Front End developer."',
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
                        size: 30.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        redirect(
                            'https://www.facebook.com/profile.php?id=100012796634175');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 30.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        _launchMail('vigneshvicky8384@gmail.com');
                      },
                      icon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey[700],
                        size: 35.0,
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        redirect('https://www.instagram.com/vignesh_hendrix/');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 30.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        redirect(
                            'https://www.linkedin.com/in/vignesh-k-53a0651b1/');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: 30.0,
                        color: Colors.grey[700],
                      ),
                      splashColor: Colors.blue,
                      color: Colors.black,
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
