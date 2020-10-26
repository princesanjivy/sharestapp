import 'package:sharestapp/font_awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors
                      .white, //should do an app icon and add that in this circleavatar(later).
                  radius: 90.0,
                ),
                accountName: Text(
                  'Sharestapp',
                  style: GoogleFonts.lato(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  "\'I'll make it Simple\'",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.black,
                ),
                title: Text(
                  'Credits',
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    content: Text('Credits'),
                    duration: Duration(
                      seconds: 5,
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.rate_review_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  'Rate & Review',
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    content: Text('Rate & Review'),
                    duration: Duration(
                      seconds: 5,
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesome.instagram,
                  color: Colors.black,
                ),
                title: Text(
                  'Shared Count of Instagram Images',
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    content: Text('Shared Count'),
                    duration: Duration(
                      seconds: 5,
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'About',
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    content: Text('About'),
                    duration: Duration(
                      seconds: 5,
                    ),
                    backgroundColor: Colors.blueAccent,
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

