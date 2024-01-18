import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_star_fitness/modules/views/AuthScreens/forgotPassword.dart';
import 'package:five_star_fitness/modules/views/AuthScreens/signup.dart';
import 'package:five_star_fitness/modules/views/homeScreen.dart';
import 'package:five_star_fitness/modules/widgets/textFieldDecoration.dart';
import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool obscure = true;
  String? error;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
              child: Icon(Icons.error_outline_sharp, color: Colors.white,),
            ),
            Expanded(
              child: Text(error!,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white,),
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
                    left: 87, right: 87, top: mediaQuery.height * 0.08),
                height: mediaQuery.height * 0.24,
                width: mediaQuery.width,
                child: Image.asset('assets/images/logo.png'),
              ),
              Text(
                'LOGIN',
                style: TextStyle(
                    color: veryLight, fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32, right: 32, top: 35),
                      child: TextFormField(
                        decoration:
                            textFieldDecoration.copyWith(labelText: "Email"),
                        controller: email,
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
                      padding:
                          const EdgeInsets.only(left: 32, right: 32, top: 16),
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
                            labelText: "Password"),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32, top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if(_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CupertinoActivityIndicator();
                      },
                    );
                    try{
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text.trim(),
                          password: password.text.trim()
                      );
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('email', email.text.trim());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false
                      );
                    } on FirebaseAuthException catch(e){
                      Navigator.pop(context);
                      setState(() {
                        error = e.message;
                      });
                    }
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  height: 52,
                  width: 222,
                  decoration: BoxDecoration(
                    color: dark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
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
                  Text('Don\'t have an account? ',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 18)),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text('Sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: dark,
                            fontSize: 20)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}