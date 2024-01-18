import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class Steps extends StatefulWidget {
  final orderId;
  const Steps({Key? key, required this.orderId}) : super(key: key);

  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {

  var upiId;
  utils() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('utils').doc('upi').get();
    setState(() {
      upiId = ds.get('upiId');
    });
  }

  @override
  void initState() {
    super.initState();
    utils();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          'Steps for payment',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. You can pay using any payments app on the following',
                  style: TextStyle(
                    fontSize: 18,
                    color: veryLight,
                  ),
                ),
                SizedBox(height: 5,),
                Text('UPI id: $upiId',
                  style: TextStyle(
                    fontSize: 18,
                    color: dark,
                  ),
                ),
                SizedBox(height: 25,),
                Text('2. OrderId is copied to your clipboard, paste it in the note as shown in below image.',
                  style: TextStyle(
                    fontSize: 18,
                    color: veryLight,
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      FlutterClipboard.copy(widget.orderId).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('OrderId copied to Clipboard',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: dark,
                        ));
                        return;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.075,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text('Copy orderId',
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
                SizedBox(height: 25),
                Center(
                  child: Image.asset('assets/images/eg.jpeg',
                    fit: BoxFit.fitWidth,
                    height: 200,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                              (route) => false);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Your subscription will be activated shortly.',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ));
                      return;
                    },
                    child: Text('Done',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}