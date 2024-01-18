import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Events',
          style: TextStyle(color: veryLight, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: background,
        iconTheme: IconThemeData(color: veryLight),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('events').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return snapshot.data!.docs.length == 0 ?
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    Icon(
                      Icons.event,
                      color: dark,
                      size: 40,
                    ),
                    SizedBox(height: 15),
                    Text('No events available',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22
                      ),
                    ),
                  ],
                ),
              ),
            ) :
            Padding(
              padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    margin: EdgeInsets.fromLTRB(5,5,5,30),
                    elevation: 8,
                    color: light,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          child: Image.network(snapshot.data!.docs[index]['photo']),
                            borderRadius: BorderRadius.circular(20),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(snapshot.data!.docs[index]['title'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10,5,10,10),
                          child: Text(snapshot.data!.docs[index]['description'],
                            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}