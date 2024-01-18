import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/steps.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  final validity, price, admissionFee, orderId, name;
  const Checkout(
      {Key? key,
      required this.name,
      required this.validity,
      required this.price,
      required this.admissionFee,
      required this.orderId})
      : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var total;
  var expiryDate;
  var today = DateTime.now();

  @override
  void initState() {
    super.initState();
    total = int.parse(widget.price) + int.parse(widget.admissionFee);
    expiryDate = new DateTime(today.year, today.month + int.parse(widget.validity), today.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
              color: veryLight, fontWeight: FontWeight.bold, fontSize: 22),
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Order Details',
                style: TextStyle(color: dark, fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width * 0.5,
              child: Divider(
                color: dark,
                thickness: 1.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 2),
              child: Text(
                widget.name,
                style: TextStyle(color: veryLight, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Text(
                widget.validity + " months validity for ₹" + widget.price,
                style: TextStyle(color: veryLight, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Row(
                children: [
                  Text(
                    'M.R.P.',
                    style: TextStyle(color: veryLight, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    "₹" + widget.price,
                    style: TextStyle(color: veryLight, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text(
                    'Admission Fee',
                    style: TextStyle(color: veryLight, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    "₹" + widget.admissionFee,
                    style: TextStyle(color: veryLight, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: dark,
                child: Row(
                  children: [
                    Text(
                      'Total Payable',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      "₹$total",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 60),
              child: Text(
                'Order Id: ${widget.orderId}',
                style: TextStyle(color: veryLight),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {

                  DocumentSnapshot ds = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid).get();

                  var sub = ds.get('subscription');
                  var attendance = ds.get('attendance');

                  if(sub.isNotEmpty){
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid).collection('pastSubscription').doc().set({
                      'subscription': sub,
                      'attendance': attendance,
                      'datetime': DateTime.now(),
                    });
                  }

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    'subscription': {
                      'datetime': DateTime.now(),
                      'orderId': widget.orderId,
                      'plan': widget.name,
                      'validity': widget.validity + ' months',
                      'expiryDate': expiryDate,
                      'active': false,
                      'amount': total,
                    },
                    "attendance": [],
                  });
                  FlutterClipboard.copy(widget.orderId).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('OrderId copied to Clipboard',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: dark,
                    ));
                    return;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Steps(
                    orderId: widget.orderId
                  )));
                },
                child: Text('Next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: dark,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}