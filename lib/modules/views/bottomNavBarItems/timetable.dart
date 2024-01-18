import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {

  List timetable = [];

  getData() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('timetable').doc('timetable').get();
    timetable.addAll(ds.get('timetable'));
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
          itemCount: timetable.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return ExpansionTile(
              collapsedIconColor: veryLight,
              iconColor: veryLight,
              title: Padding(
                padding: EdgeInsets.all(8),
                child: Text(timetable[index]['day'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              children: [
                ListView.builder(
                  itemCount: timetable[index]['slots'].length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index1){
                    return Card(
                      color: darkOg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(timetable[index]['slots'][index1]['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(timetable[index]['slots'][index1]['time'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}