import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/drawerItems/subscriptions.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../editProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Center(
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child:
                    Hero(
                      tag: snapshot.data!['name'],
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: dark,
                        child: Text(snapshot.data!['name'].substring(0,1).toUpperCase(),
                          style: TextStyle(color: veryLight, fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Text(snapshot.data!['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: veryLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(snapshot.data!['phone'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: veryLight,
                      ),
                    ),
                  ),
                  Text(snapshot.data!['email'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: veryLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Divider(
                      color: veryLight,
                    ),
                  ),
                  Center(
                      child: snapshot.data!['subscription'].isEmpty ? Column(
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
                      ) : snapshot.data!['subscription']['active'] == true ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Active plan:',
                            style: TextStyle(
                              color: veryLight,
                            ),
                          ),
                          Text(
                            snapshot.data!['subscription']['plan'],
                            style: TextStyle(color: dark, fontSize: 18),
                          ),
                        ],
                      ) : Text(
                        'Your subscription will be activated shortly.',
                        style: TextStyle(
                          color: veryLight,
                          fontSize: 16,
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10,20,10,8),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(
                            name: snapshot.data!['name'],
                            height: snapshot.data!['height'],
                            phone: snapshot.data!['phone'],
                            weight: snapshot.data!['weight'],
                            email: snapshot.data!['email'],
                            dob: snapshot.data!['dob'],
                            gender: snapshot.data!['gender']
                        )));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: dark,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text('Edit profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.48,
                          height: MediaQuery.of(context).size.height * 0.25,
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
                                        'Gender',
                                        style: TextStyle(
                                            color: veryLight,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      Text(snapshot.data!['gender'],
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
                                        'Dob',
                                        style: TextStyle(
                                            color: veryLight,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(snapshot.data!['dob'])),
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
                          height: MediaQuery.of(context).size.height * 0.25,
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
                                        'Height',
                                        style: TextStyle(
                                            color: veryLight,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      Text(snapshot.data!['height'] + ' cm',
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
                                      Text(snapshot.data!['weight'] + ' kg',
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
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}