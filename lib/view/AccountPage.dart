import 'package:flutter/material.dart';

import '../util/AbstractUser.dart';
import '../util/CommonAppBar.dart';
import '../db/DatabaseAccessor.dart';
import '../model/VeteranUser.dart';

class AccountPage extends StatefulWidget {

  final AbstractUser user;

  AccountPage({Key key, this.user}) : super(key: key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {

  final OutlineInputBorder inputFieldBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(const Radius.circular(10)),
      borderSide: BorderSide(
          color: Colors.amberAccent,
          width: 2.0
      )
  );

  @override
  void initState() {
    db.initialize();
    super.initState();
  }

  bool pressed = false;
  bool emailVerified = true;

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: db.getAbstractUserFirstName(widget.user.uniqueID));
    final lastNameController = TextEditingController(text: db.getAbstractUserLastName(widget.user.uniqueID));
    final emailController = TextEditingController(text: db.getAbstractUserEmail(widget.user.uniqueID));

    final TextFormField firstNameField = TextFormField(
        controller: firstNameController,
        enabled: pressed,
        obscureText: false,
        textInputAction: TextInputAction.done,
        //style: inputFieldStyle,
        decoration: InputDecoration(
            labelText: "First Name",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: inputFieldBorder,
            enabledBorder: inputFieldBorder
        )
    );

    final TextFormField lastNameField = TextFormField(
        controller: lastNameController,
        enabled: pressed,
        obscureText: false,
        //style: inputFieldStyle,
        decoration: InputDecoration(
            labelText: "Last Name",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: inputFieldBorder,
            enabledBorder: inputFieldBorder
        )
    );

    final TextFormField emailField = TextFormField(
        controller: emailController,
        enabled: pressed,
        obscureText: false,
        //style: inputFieldStyle,
        decoration: InputDecoration(
            labelText: "Email",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: inputFieldBorder,
            enabledBorder: inputFieldBorder
        )
    );


    return Scaffold(
        appBar: CommonAppBar("My Account", true, context),
        body: Center(
            child: Container(
                color: Colors.white,
                child: ListView (
                  padding: const EdgeInsets.all(36.0),
                  children: <Widget>[


                    //profile picture
                    SizedBox(
                    height: 155.0,
                    child: Image.asset(
                        "lib/assets/default_user_icon.png",
                        fit: BoxFit.contain
                      )
                    ),

                   Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(32.0),
                        color: pressed == false ? Colors.amberAccent : Colors.greenAccent,
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              if (pressed == false) {
                                setState(() { pressed = true; });
                              }
                              else {
                                setState(() {

                                    String newFirstName;
                                    String newLastName;
                                    String newEmail;
                                    if (firstNameController.text != db.getAbstractUserFirstName(widget.user.uniqueID)) {
                                      newFirstName = firstNameController.text;
                                    }
                                    if (lastNameController.text != db.getAbstractUserLastName(widget.user.uniqueID)) {
                                      newLastName = lastNameController.text;
                                    }
                                    if (emailController.text != db.getAbstractUserEmail(widget.user.uniqueID)) {
                                      newEmail = emailController.text;
                                    }

                                    bool changedStatus = db.changeAbstractUserInfo(widget.user.uniqueID, newFirstName, newLastName, newEmail);

                                    if (changedStatus == true)
                                      pressed = !pressed;
                                    else
                                      {}
                                      //display an error
                                });
                              }
                            },
                            child: Text(pressed == false ? "Update Info" : "Done",
                                textAlign: TextAlign.center
                            )
                        )
                    ),



                    //first name
                    Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: firstNameField
                    ),


                    //last name
                    Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: lastNameField
                    ),


                    Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: emailField
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(
                              emailVerified ? Icons.verified_user : Icons.notification_important,
                              size: 40.0
                          )
                        )
                      ]
                    )

                  ]
                )
            )
        )
    );
  }
}