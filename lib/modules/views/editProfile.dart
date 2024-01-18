import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/AuthScreens/changePassword.dart';
import 'package:five_star_fitness/modules/widgets/textFieldDecoration.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  final name, phone, height, weight, email, dob, gender;
  const EditProfile({Key? key, required this.name, required this.height, required this.phone, required this.weight, required this.email, required this.dob, required this.gender}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final genderList = ["Male", "Female", "Others"];
  var selected;
  bool loading = false;

  data() {
    name.text = widget.name;
    phone.text = widget.phone;
    height.text = widget.height;
    weight.text = widget.weight;
    selected = widget.gender;
    dobController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.dob));
  }

  @override
  void initState() {
    super.initState();
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Edit profile',
          style: TextStyle(
              color: veryLight, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: background,
        iconTheme: IconThemeData(color: veryLight),
        actions: [
          IconButton(
            onPressed: () async {
              if(_formKey.currentState!.validate()){
                setState(() {
                  loading = true;
                });
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'name' : name.text.trim(),
                  "height": height.text.trim(),
                  "weight": weight.text.trim(),
                  "gender": selected.toString(),
                  "dob": dobController.text.trim(),
                  "phone": phone.text.trim(),
                });
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.done),
            color: dark,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: loading ?
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: Center(
            child: CircularProgressIndicator(
              color: dark,
            ),
          ),
        ) : Column(
          children: [
            SizedBox(height: 20,),
            Text(widget.email,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: veryLight,
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(13),
                    child: TextFormField(
                      decoration:
                      textFieldDecoration.copyWith(labelText: "Name"),
                      controller: name,
                      validator: (val) {
                        if (val!.isEmpty) return 'Name can\'t be empty';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(13),
                    child: TextFormField(
                      decoration: textFieldDecoration.copyWith(labelText: "Phone Number",counterText: ""),
                      controller: phone,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val!.isEmpty) return 'Phone number can\'t be empty';
                        if (val.length != 10) return 'Enter valid phone number';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(13),
                    child: TextFormField(
                      decoration: textFieldDecoration.copyWith(labelText: "Height (in cm)"),
                      controller: height,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val!.isEmpty) return 'Height can\'t be empty';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(13),
                    child: TextFormField(
                      decoration: textFieldDecoration.copyWith(labelText: "Weight (in kg)"),
                      keyboardType: TextInputType.number,
                      controller: weight,
                      validator: (val) {
                        if (val!.isEmpty) return 'Weight can\'t be empty';
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: outlineInputBorder,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text('Gender'),
                                      isExpanded: true,
                                      value: selected,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selected = newValue;
                                        });
                                      },
                                      items: genderList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: TextFormField(
                              controller: dobController,
                              readOnly: true,
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                              style: TextStyle(color: Colors.white),
                              onTap: () async {
                                var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                );
                                dobController.text =
                                    date.toString().substring(0, 10);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(
                color: veryLight,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(email: widget.email,)));
                  },
                  child: Text('Change password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: dark,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}