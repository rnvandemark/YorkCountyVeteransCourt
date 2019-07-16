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

  final TextStyle inputFieldStyle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20.0
  );

  int attemptState = 0;
  String emailFieldValue = "";
  String passwordFieldValue = "";

  @override
  void initState() {
    db.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    if (this.attemptState == 1) {
      emailController.text = this.emailFieldValue;
      passwordController.text = this.passwordFieldValue;
    }

    final OutlineInputBorder inputFieldBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: BorderSide(
            color: (this.attemptState == 2) ? Colors.red : FOREGROUND_COLOR,
            width: 2.0
        )
    );

    final FocusNode inputFieldFocusNode = FocusNode();

    final TextField emailField = TextField(
        controller: emailController,
        obscureText: false,
        style: inputFieldStyle,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border: inputFieldBorder,
            enabledBorder: inputFieldBorder
        ),
        focusNode: inputFieldFocusNode
    );

    final TextField passwordField = TextField(
        controller: passwordController,
        obscureText: true,
        style: inputFieldStyle,
        decoration: emailField.decoration.copyWith(hintText: "Password")
    );

    inputFieldFocusNode.addListener(() {
      if (this.attemptState == 2) {
        this.setState(() {
          this.attemptState = 1;
        });
      }
    });

    final Material loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(32.0),
        color: FOREGROUND_COLOR,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              this.emailFieldValue = "";
              this.passwordFieldValue = "";

              AbstractUser validUser = db.validateUserCredentials(
                  emailController.text,
                  passwordController.text
              );

              if (validUser == null) {
                setState(() => this.attemptState = 2);
              } else {
                this.attemptState = 0;
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                      return VeteranUserLandingPage(user: validUser);
                    })
                );
              }
            },
            child: Text("Login",
                textAlign: TextAlign.center,
                style: inputFieldStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                )
            )
        )
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
                        children: <Widget> [
                          Image.asset(
                              "lib/assets/york_county_pa_logo.png",
                              fit: BoxFit.contain,
                              height: 150.0
                          ),
                          SizedBox(height: 25.0),
                          emailField,
                          SizedBox(height: 25.0),
                          passwordField,
                          SizedBox(height: 35.0),
                          loginButton,
                          SizedBox(height: 15.0)
                        ]
                    )
                )
            )
        )
    );
  }
}