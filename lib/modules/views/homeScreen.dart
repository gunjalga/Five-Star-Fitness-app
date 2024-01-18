import 'package:five_star_fitness/modules/views/bottomNavBarItems/timetable.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import 'bottomNavBarItems/home.dart';
import 'bottomNavBarItems/profile.dart';
import 'bottomNavBarItems/qrScanner.dart';
import 'bottomNavBarItems/trainerInfo.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final tabs = [
    Home(),
    Timetable(),
    QrScanner(),
    TrainerInfo(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: selectedIndex != 2 ? AppBar(
        title: Text(selectedIndex == 0 ? 'Home' : selectedIndex == 1 ? 'Timetable' : selectedIndex == 3 ? 'Trainers' : 'Profile',
          style: TextStyle(color: veryLight, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: background,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              child: Container(
                  height: 40,
                  width: 40,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  )),
              borderRadius: BorderRadius.circular(20),
            ),
          )
        ],
        iconTheme: IconThemeData(
          color: veryLight
        ),
      ) : null,
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: background,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home_outlined.png',
              color: light,
              height: 24,
            ),
            activeIcon: Image.asset(
              'assets/images/home_filled.png',
              color: light,
              height: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.insert_chart_outlined,
              size: 30,
              color: light,
            ),
            activeIcon: Icon(
              Icons.insert_chart,
              size: 30,
              color: light,
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: light
              ),
              child: Icon(
                Icons.camera_outlined,
                size: 30,
                color: darkOg,
              ),
            ),
            activeIcon: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: light
              ),
              child: Icon(
                Icons.camera,
                size: 30,
                color: darkOg,
              ),
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/whistle_outlined.png',
              color: light,
              height: 26,
            ),
            activeIcon: Image.asset(
              'assets/images/whistle_filled.png',
              color: light,
              height: 26,
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/person_outlined.png',
              color: light,
              height: 26,
            ),
            activeIcon: Image.asset(
              'assets/images/person_filled.png',
              color: light,
              height: 26,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}