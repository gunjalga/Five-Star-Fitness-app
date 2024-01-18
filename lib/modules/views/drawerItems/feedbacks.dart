import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/widgets/textFieldDecoration.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../homeScreen.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({Key? key}) : super(key: key);

  @override
  _FeedbacksState createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {

  TextEditingController feedback = TextEditingController();
  var star = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Feedback',
          style: TextStyle(color: veryLight, fontWeight: FontWeight.bold, fontSize: 22),
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
              padding: EdgeInsets.fromLTRB(22,10,22,5),
              child: Text('Rate Your Experience',
                style: TextStyle(
                  color: dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 22),
              child: Text('Are you Satisfied with the Service?',
                style: TextStyle(
                  color: veryLight,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
              child: RatingBar.builder(
                initialRating: 5,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                glow: false,
                itemSize: 50,
                onRatingUpdate: (rating) {
                  setState(() {
                    star = rating;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Divider(
                color: dark,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
              child: Text('Tell us what can be improved?',
                style: TextStyle(
                  color: dark,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(22,1,22,50),
                child: TextFormField(
                  decoration: textFieldDecoration.copyWith(hintText: "Tell us on how can we improve...", hintStyle: TextStyle(color: veryLight)),
                  controller: feedback,
                  maxLines: 10,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await FirebaseFirestore.instance.collection('feedbacks').doc().set(
                  {
                    'uid': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                    'details': feedback.text.trim(),
                    'star': star,
                  }
                );
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                'Your feedback is submitted successfully.',
                                style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    decoration: TextDecoration.none
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => HomeScreen()),
                                          (Route<dynamic> route) => false
                                  );
                                },
                                child: Text(
                                  'Ok',
                                  style: TextStyle(
                                      color: Colors.blue),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  elevation: 0,
                                  side: BorderSide(
                                      color: Colors.blue),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          5)),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              behavior: HitTestBehavior.translucent,
              child: Center(
                child: Container(
                  height: 52,
                  width: 222,
                  decoration: BoxDecoration(
                    color: dark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}