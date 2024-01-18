import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/homeScreen.dart';
import 'package:five_star_fitness/provider/date.dart';
import 'package:five_star_fitness/provider/subscribed.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  List date = [DateTime.now().toString()];
  bool marked = true;
  bool sub = false;

  addDate() async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'attendance': FieldValue.arrayUnion(date)
    }).then((value) {

      controller!.dispose();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Attendance marked!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));

    });

  }

  mark() {
    marked = Provider.of<TodayDate>(context, listen: false).getToday;
    sub = Provider.of<Subscribed>(context, listen: false).getSub;
  }

  @override
  void initState() {
    super.initState();
    mark();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return sub ? marked ? Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
            bottom: MediaQuery.of(context).size.height*0.15,
            child: buildResult(),
          )
        ],
      )
    ) : Scaffold(
      backgroundColor: background,
      body: Center(
        child: Text('You have already marked\nyour attendance for today.',
          textAlign: TextAlign.center,
          style: TextStyle(color: veryLight, fontSize: 18),
        ),
      ),
    ) :
    Scaffold(
      backgroundColor: background,
      body: Center(
        child: Text('You don\'t have any active subscription.',
          style: TextStyle(color: veryLight, fontSize: 18),
        ),
      ),
    );
  }

  Widget buildResult() {
    return Container(
        decoration: BoxDecoration(color: Colors.white24),
        child: Text('Scan QR code',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        )
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      cutOutSize: MediaQuery.of(context).size.width * 0.8,
      borderRadius: 10,
    ),
  );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) async {
      setState(() {
        this.barcode = barcode;
      });

      if(barcode.code == 'Welcome to Five Star Fitness!!') {
        addDate();
      }
    });
  }
}