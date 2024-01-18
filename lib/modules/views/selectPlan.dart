import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/checkout.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectPlan extends StatefulWidget {
  final Map<dynamic, dynamic> subscription;
  const SelectPlan({Key? key, required this.subscription}) : super(key: key);

  @override
  _SelectPlanState createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {

  int ?_selectedIndex;
  var validity;
  var price;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Select Plan',
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
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                color: dark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.subscription['name'],
                    style: TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 1.5,
                      width: 2,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Starting At',
                        style: TextStyle(
                            color: Colors.white, fontSize: 14),
                      ),
                      Text('₹' + widget.subscription['plan'][0]['price'],
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            ),
            if(_selectedIndex != null) (
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    'The subscription is only valid for $validity ${_selectedIndex == 0 ? 'month' : 'months'}.',
                    style: TextStyle(
                        color: veryLight, fontSize: 15),
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text('Select Session',
                style: TextStyle(
                  color: dark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                      validity = widget.subscription['plan'][index]['validity'];
                      price = widget.subscription['plan'][index]['price'];
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
                          Text(widget.subscription['plan'][index]['validity'] + " ${index == 0 ? 'month' : 'months'} validity @ ₹" + widget.subscription['plan'][index]['price'],
                            style: _selectedIndex == index
                                ? TextStyle(color: Colors.white, fontSize: 16)
                                : TextStyle(color: dark, fontSize: 16),
                          ),
                          Spacer(),
                          _selectedIndex == index ?
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ) : Container()
                        ],
                      ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  if (validity == null || price == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Select Session',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 15),
                                Text('Notice',
                                  style: TextStyle(
                                    color: dark,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 8),
                                  child: Divider(
                                    color: dark,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'You have selected a $validity ${_selectedIndex == 0 ? 'month' : 'months'} Session.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Select Other',
                                        style: TextStyle(color: dark),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        elevation: 0,
                                        side: BorderSide(color: dark),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => Checkout(
                                            name: widget.subscription['name'],
                                            validity: validity,
                                            price: price,
                                            admissionFee: widget.subscription['AdmissionFee'],
                                            orderId: uid.substring(0, 6) + DateFormat('ddMMyyyyhhmmss').format(now),
                                          )),
                                        );
                                      },
                                      child: Text('Proceed'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
                child: Text('Get The Plan',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  primary: dark,
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                ),
              ),
              alignment: Alignment.center,
            ),
          ],
        )
      ),
    );
  }
}