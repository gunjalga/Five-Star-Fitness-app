import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/AuthScreens/login.dart';
import 'package:five_star_fitness/modules/views/drawerItems/rulesAndRegulations.dart';
import 'package:five_star_fitness/modules/widgets/textFieldDecoration.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../homeScreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final genderList = ["Male", "Female", "Others"];
  var selected;
  bool? checked = false;
  bool obscure = true;
  String? error;

  Widget showAlert() {
    if (error != null) {
      return Container(
        color: Colors.red,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.error_outline_sharp,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Text(
                error!,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  @override
  void initState() {
    super.initState();
    dobController.text = DateTime.now().toString().substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 87, right: 87, top: mediaQuery.height * 0.04),
                height: mediaQuery.height * 0.24,
                width: mediaQuery.width,
                child: Image.asset('assets/images/logo.png'),
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, top: 35),
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
                      padding: EdgeInsets.only(left: 32, right: 32, top: 16),
                      child: TextFormField(
                        decoration: textFieldDecoration.copyWith(
                          labelText: "Phone Number",
                          prefix: Text('+91 '),
                          counterText: "",
                        ),
                        maxLength: 10,
                        controller: phone,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) return 'Phone number can\'t be empty';
                          if (val.length != 10) return 'Enter valid phone number';
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, top: 16),
                      child: TextFormField(
                        decoration:
                            textFieldDecoration.copyWith(labelText: "Email"),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) return 'Email can\'t be empty';
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) return 'Enter a valid email';
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, top: 16),
                      child: TextFormField(
                        decoration: textFieldDecoration.copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(obscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            color: Colors.grey,
                          ),
                          labelText: "Password",
                        ),
                        obscureText: obscure,
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) return 'Password can\'t be empty';
                          if (value.length < 8)
                            return 'Password must be at least 8 characters';
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 18),
                      child: Row(
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
                                width: mediaQuery.width / 2.6,
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
                                width: mediaQuery.width / 2.6,
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 32),
                  child: Row(
                    children: [
                      Checkbox(
                          value: checked,
                          activeColor: dark,
                          onChanged: (val) {
                            setState(() {
                              checked = val;
                              print(checked);
                            });
                          }),
                      Text(
                        'I accept all the',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: veryLight),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        child: Text(
                          'Rules and Regulations',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: dark),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RulesAndRegulations()));
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if (selected == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Select gender',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }

                  if (checked == false) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please accept the Rules and Regulations to Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CupertinoActivityIndicator();
                      },
                    );
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email.text.trim(),
                              password: password.text.trim())
                          .then((value) async {
                        if (value.user != null) {
                          Map<String, dynamic> userInfoMap = {
                            "uid": FirebaseAuth.instance.currentUser!.uid,
                            "email": email.text.trim(),
                            "name": name.text.trim(),
                            "height": '',
                            "weight": '',
                            "gender": selected.toString(),
                            "dob": dobController.text.trim(),
                            "phone": phone.text.trim(),
                            "attendance": [],
                            "screeningResult": [],
                            "subscription": {},
                          };
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(userInfoMap['uid'])
                              .set(userInfoMap, SetOptions(merge: true));
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('email', email.text.trim());

                          final SharedPreferences prefsPhone =
                          await SharedPreferences.getInstance();
                          prefsPhone.setString('phone', phone.text.trim());

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false);
                        }
                      });
                    } on FirebaseAuthException catch (e) {
                      Navigator.pop(context);
                      setState(() {
                        error = e.message;
                      });
                    }
                  }
                },
                child: Container(
                  height: 52,
                  width: 222,
                  decoration: BoxDecoration(
                    color: dark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              showAlert(),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 18)),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: dark,
                            fontSize: 20)),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
