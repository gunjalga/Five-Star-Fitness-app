import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import '../selectPlan.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {

  List subscriptions = [];

  getData() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('subscriptions').doc('subscription').get();
    subscriptions.addAll(ds.get('subscriptions'));
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
      appBar: AppBar(
        title: Text('Choose a Plan',
          style: TextStyle(
            color: veryLight,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: background,
        iconTheme: IconThemeData(color: veryLight),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
              child: Text('Begin Your\nJourney Now!',
                style: TextStyle(
                  color: veryLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Divider(
                thickness: 0.5,
                color: veryLight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text('Select your plan',
                style: TextStyle(
                  color: dark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 40),
              itemCount: subscriptions.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPlan(
                        subscription: subscriptions[index]
                    )));
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      color: darkOg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: Row(
                          children: [
                            Text(subscriptions[index]['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            CircleAvatar(
                              backgroundColor: veryLight,
                              radius: 15,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: dark,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}