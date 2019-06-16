import 'package:flutter/material.dart';

import '../util/References.dart';
import '../db/DatabaseAccessor.dart';
import '../util/AbstractUser.dart';
import '../view/VeteranUserLandingPage.dart';

class LoginPage extends StatefulWidget {

  final String title;

  LoginPage({Key key, this.title}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  Color textFieldColor = Colors.black;
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20.0
  );

  @override
  void initState() {
    super.initState();
    db.populateVeteranUsers();
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final emailField = TextField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      )
    );

    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      )
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: FOREGROUND_COLOR,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          AbstractUser validUser = db.validateUserCredentials(
              emailController.text,
              passwordController.text
          );

          if (validUser == null)
          {
            setState(() {
              textFieldColor = Colors.red;
            });
          }
          else
          {
            Navigator.of(context).push(
                MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return VeteranUserLandingPage(user: validUser);
                })
            );
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: MAIN_TEXT_COLOR,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150.0,
                  child: Image.asset(
                    "lib/assets/york_county_pa_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 25.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 35.0),
                loginButton,
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}