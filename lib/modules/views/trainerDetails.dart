import 'dart:io';

import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainerDetails extends StatefulWidget {
  final Map<dynamic, dynamic> details;
  final index;
  const TrainerDetails({Key? key, required this.details, required this.index})
      : super(key: key);

  @override
  _TrainerDetailsState createState() => _TrainerDetailsState();
}

class _TrainerDetailsState extends State<TrainerDetails> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: veryLight),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: widget.index,
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: NetworkImage(widget.details['photo']),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.details['name'],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              Text(
                widget.details['charge'],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Text(
                  widget.details['bio'],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _makePhoneCall('tel:${widget.details['phone']}');
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Icon(
                    Icons.call,
                    color: dark,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(
                  color: veryLight,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.48,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Card(
                        color: light.withOpacity(0.5),
                        elevation: 0,
                        shadowColor: light,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Age',
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    widget.details['age'],
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Height',
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    widget.details['height'],
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Weight',
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    widget.details['weight'],
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.48,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Card(
                        color: light.withOpacity(0.5),
                        elevation: 0,
                        shadowColor: light,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Certification',
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        widget.details['certification'].length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Text(
                                          widget.details['certification']
                                              [index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: veryLight,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Year of exp',
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    widget.details['experience'],
                                    style: TextStyle(
                                        color: veryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
