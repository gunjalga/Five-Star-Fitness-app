import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../homeScreen.dart';

class GetHelp extends StatefulWidget {
  const GetHelp({Key? key}) : super(key: key);

  @override
  _GetHelpState createState() => _GetHelpState();
}

class _GetHelpState extends State<GetHelp> {

  int? _selectedIndex;
  List bookingItems = [
    'Workshop',
    'Fitness Test',
    'Nutrition Counselling',
    'Body Massage'
  ];
  var appointment;
  var phone;

  getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone');
  }

  @override
  void initState() {
    super.initState();
    getPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_rounded),
                        color: veryLight,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('Book an \nappointment now!',
                        style: TextStyle(
                          color: veryLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Divider(
                  thickness: 0.5,
                  color: veryLight,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        appointment = bookingItems[index];
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      padding: EdgeInsets.fromLTRB(15, 22, 10, 22),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index ? dark : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: dark),
                      ),
                      child: Row(
                        children: [
                          Text(bookingItems[index],
                            style: _selectedIndex == index
                                ? TextStyle(color: Colors.white, fontSize: 16)
                                : TextStyle(color: dark, fontSize: 16),
                          ),
                          Spacer(),
                          _selectedIndex == index ?
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ) :
                          Container()
                        ],
                      ),
                    ),
                  );
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (appointment == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Select appointment',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  } else {
                    await FirebaseFirestore.instance
                        .collection('appointments')
                        .doc()
                        .set({
                      'uid': FirebaseAuth.instance.currentUser!.uid,
                      'datetime': DateTime.now(),
                      'appointmentType': appointment,
                      'phone': phone
                    }).then((value) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                              (route) => false);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Appointment Booked! You will hear from us soon.',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ));
                    });
                  }
                },
                child: Text('Book Appointment',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  primary: dark,
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                ),
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}