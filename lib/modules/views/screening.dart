import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';

class Screening extends StatefulWidget {
  const Screening({
    Key? key,
  }) : super(key: key);

  @override
  _ScreeningState createState() => _ScreeningState();
}

class _ScreeningState extends State<Screening> {
  List questions = [
    '1. Has your physician ever told you that you have heart condition?',
    '2. Do you experience pain in your chest when you are physically active?',
    '3. In the past month, have you experienced chest pain when not performing physical activity?',
    '4. Do you lose balance because of dizziness or do you ever lose consciousness?',
    '5. Do you have a bone or joint problem that could be aggravated by a change in your level of physical activity?',
    '6. Is your physician currently prescribing medications for your blood pressure or a heart condition?',
    '7. Do you know of any other reason why you should not participate in a physical activity programme?'
  ];
  List<bool> yesChecked = [false, false, false, false, false, false, false];
  List<bool> noChecked = [false, false, false, false, false, false, false];
  List result = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text(
            'Pre-activity Screening',
            style: TextStyle(
                color: veryLight, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: background,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Checkbox(
                                value: yesChecked[index],
                                activeColor: dark,
                                onChanged: (val) {
                                  setState(() {
                                    yesChecked[index] = val!;
                                    noChecked[index] = !val;
                                  });
                                }),
                            Text(
                              'Yes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: veryLight),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                value: noChecked[index],
                                activeColor: dark,
                                onChanged: (val) {
                                  setState(() {
                                    noChecked[index] = val!;
                                    yesChecked[index] = !val;
                                  });
                                }),
                            Text(
                              'No',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: veryLight),
                            )
                          ],
                        ),
                        Expanded(
                          child: Text(
                            questions[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: veryLight),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
                itemCount: questions.length,
                shrinkWrap: true,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  result.clear();
                  for(int i = 0; i< yesChecked.length; i++){
                    if(yesChecked[i] == true){
                      result.add(questions[i]);
                    }
                  }
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    "screeningResult": result.isNotEmpty ? result : ['none'],
                  });
                  Navigator.pop(context);
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
            ],
          ),
        ),
      ),
    );
  }
}