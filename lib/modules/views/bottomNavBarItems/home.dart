import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/drawerItems/subscriptions.dart';
import 'package:five_star_fitness/modules/views/screening.dart';
import 'package:five_star_fitness/provider/date.dart';
import 'package:five_star_fitness/provider/subscribed.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../homeScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Map<dynamic, dynamic> subscription = {};
  String name ='';
  String today = DateFormat('yyyy-M-d').format(DateTime.parse(DateTime.now().toString()));
  String? lastDate;
  DateTime? firstDaySub;
  List attendance = [];
  List formattedDate = [];
  List year = [];
  int difference = 0;
  List screeningResult=[];

  getData() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      subscription = ds.get('subscription');
      attendance.addAll(ds.get('attendance'));
      name = ds.get('name');
      screeningResult =ds.get('screeningResult');
    });
    if(screeningResult.isEmpty){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Screening()));
    }
      if (subscription['active'] == true) {
        Provider.of<Subscribed>(context, listen: false).setSub = true;
      }

      if(subscription.isNotEmpty){
        if (subscription['expiryDate'].toDate().isBefore(DateTime.now())) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid).collection('pastSubscription').doc().set({
            'subscription': subscription,
            'attendance': attendance,
            'datetime': DateTime.now(),
          });

          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            'subscription': {},
            "attendance": [],
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Oops! You\'re subscription is expired.' ,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false);

        }
      }

      attendance.forEach((element) {
        if (DateFormat('yyyy').format(DateTime.parse(element)).toString() == DateTime.now().year.toString()) {
          year.add(element);

          if (DateFormat('M').format(DateTime.parse(element)).toString() == DateTime.now().month.toString()) {
            formattedDate.add(DateFormat('d').format(DateTime.parse(element)));
          }
        }
      });

      if (attendance.isNotEmpty) {
        lastDate = DateFormat('yyyy-M-d').format(DateTime.parse(attendance.last));
      }

      if (today == lastDate) {
        Provider.of<TodayDate>(context, listen: false).setToday = false;
      }

      firstDaySub = subscription['datetime'].toDate();

      difference = DateTime.now().difference(subscription['datetime'].toDate()).inDays + 1;

  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    int present = year.length;
    int sunday = 0;
    int absent = difference - sunday - present;

    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                'Welcome back,\n$name',
                style: TextStyle(
                  color: veryLight,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),
              ),
            ),
            Center(
                child: subscription.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You don\'t have any active subscription.',
                            style: TextStyle(
                              color: veryLight,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Subscriptions()));
                            },
                            child: Text(
                              'Buy subscription now!',
                              style: TextStyle(color: dark, fontSize: 18),
                            ),
                          ),
                        ],
                      )
                    : subscription['active'] == true ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You have currently subscribed to:',
                            style: TextStyle(
                              color: veryLight,
                            ),
                          ),
                          Text(
                            subscription['plan'],
                            style: TextStyle(color: dark, fontSize: 18),
                          ),
                        ],
                      ) : Text(
                        'Your subscription will be activated shortly.',
                        style: TextStyle(
                          color: veryLight,
                          fontSize: 16
                        ),
                      )
            ),
            subscription.isNotEmpty ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Divider(
                thickness: 0.5,
                color: veryLight,
              ),
            ) : Container(),
            subscription.isNotEmpty ? Padding(
              padding: EdgeInsets.fromLTRB(8, 5, 8, 25),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                color: light.withOpacity(0.5),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: CalendarCarousel<Event>(
                    showOnlyCurrentMonthDate: true,
                    selectedDayBorderColor: Colors.transparent,
                    disableDayPressed: true,
                    weekFormat: false,
                    height: MediaQuery.of(context).size.height * 0.5,
                    selectedDateTime: DateTime.now(),
                    daysHaveCircularBorder: true,
                    isScrollable: false,
                    showHeaderButton: false,
                    customGridViewPhysics: NeverScrollableScrollPhysics(),
                    dayPadding: 2.2,
                    headerTextStyle: TextStyle(
                        color: veryLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Montserrat'),
                    weekdayTextStyle: TextStyle(
                      color: veryLight,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                    customDayBuilder: (
                      bool isSelectable,
                      int index,
                      bool isSelectedDay,
                      bool isToday,
                      bool isPrevMonthDay,
                      TextStyle textStyle,
                      bool isNextMonthDay,
                      bool isThisMonthDay,
                      DateTime day,
                    ) {
                      if (day.weekday == 7) {
                        sunday = sunday + 1;
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }


                      else if (day.day <= DateTime.now().day) {
                        if (formattedDate.contains(day.day.toString())) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF05CE91),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }
                        else if(day.day < DateTime.parse(firstDaySub.toString()).day){
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }
                          else {
                          return Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFF3152),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }
                      }

                      else if (day.day == DateTime.now().day &&
                          formattedDate.contains(day.day.toString())) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF05CE91),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ) : Container(),
            subscription.isNotEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.48,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Card(
                    color: Color(0xFFeb4d91),
                    elevation: 10,
                    shadowColor: Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Total Absent',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: Offset(1, 20),
                                    child: Text(
                                      absent.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 100,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.48,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Card(
                    color: Color(0xFF21d3fe),
                    elevation: 10,
                    shadowColor: Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Total Present',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: Offset(1, 20),
                                    child: Text(
                                      present.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 100,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ) : Container(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            )
          ],
        ),
      ),
    );
  }
}