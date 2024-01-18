import 'package:firebase_core/firebase_core.dart';
import 'package:five_star_fitness/modules/views/homeScreen.dart';
import 'package:five_star_fitness/provider/date.dart';
import 'package:five_star_fitness/provider/subscribed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'modules/views/landingScreen.dart';

var email;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email');
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TodayDate()),
      ChangeNotifierProvider(create: (context) => Subscribed()),
    ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark,),
      themeMode: ThemeMode.dark,
      home: email == null ? LandingScreen() : HomeScreen(),
    );
  }
}