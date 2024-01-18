import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/drawerItems/rulesAndRegulations.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawerItems/events.dart';
import 'drawerItems/feedbacks.dart';
import 'drawerItems/getHelp.dart';
import 'drawerItems/subscriptions.dart';
import 'landingScreen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.22,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/logo.png'),
                )),
              ),
              SizedBox(height: 10),
              ...drawerItems.map((val) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        val.onTap(context);
                      },
                      title: Text(val.label,
                          style: TextStyle(
                            color: val.label == 'Logout' ? Colors.red : veryLight,
                            fontSize: 16,
                          )),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: val.label == 'Logout' ? Colors.red : veryLight,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      child: Divider(
                        color: dark,
                      ),
                    )
                  ],
                );
              }).toList(),
              Padding(
                padding: EdgeInsets.fromLTRB(5,40,5,20),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Developed by:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: light,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Feazy Solutions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: light,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'feazysolutions@gmail.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: light,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItems {
  final String label;
  final void Function(BuildContext context) onTap;

  DrawerItems({
    required this.label,
    required this.onTap,
  });
}

List<DrawerItems> drawerItems = [
  DrawerItems(
      label: 'Subscription',
      onTap: (context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Subscriptions()));
      }),
  DrawerItems(
      label: 'Events',
      onTap: (context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Events()));
      }),
  DrawerItems(
      label: 'Feedback',
      onTap: (context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Feedbacks()));
      }),
  DrawerItems(
      label: 'Book Appointment',
      onTap: (context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GetHelp()));
      }),
  DrawerItems(
      label: 'Rules and Regulations',
      onTap: (context) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RulesAndRegulations()));
      }),
  DrawerItems(
      label: 'Logout',
      onTap: (context) async {
        FirebaseAuth.instance.signOut();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LandingScreen()),
            (Route<dynamic> route) => false);
      }),
];