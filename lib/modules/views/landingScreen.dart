import 'package:five_star_fitness/modules/views/AuthScreens/login.dart';
import 'package:five_star_fitness/modules/views/AuthScreens/signup.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/landing.jpg'))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(35, mediaQuery.height*0.13, 35, 70),
                child: Text(
                  'Let\'s Get \nStarted',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: mediaQuery.height*0.12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 76,
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: dark,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                      ),
                    ),
                    Container(
                      height: 76,
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: light,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}