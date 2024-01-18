import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import '../trainerDetails.dart';

class TrainerInfo extends StatefulWidget {
  const TrainerInfo({Key? key}) : super(key: key);

  @override
  _TrainerInfoState createState() => _TrainerInfoState();
}

class _TrainerInfoState extends State<TrainerInfo> {

  List allTrainers = [];

  getData() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('trainers').doc('trainer').get();
    allTrainers.addAll(ds.get('trainers'));
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
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.4),
          ),
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: allTrainers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrainerDetails(
                            details: allTrainers[index],
                            index: index
                          )));
                },
                behavior: HitTestBehavior.translucent,
                child: Stack(
                  children: [
                    Hero(
                      tag: index,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(allTrainers[index]['photo'],
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(color: dark),
                            );
                          },
                        ),
                      )
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 20, right: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: veryLight.withOpacity(0.5)
                          ),
                          child: Text(allTrainers[index]['name'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            );
          },
        ),
      ),
    );
  }
}