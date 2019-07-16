import 'package:flutter/material.dart';

import '../util/References.dart';
import '../util/AbstractActivity.dart';
import '../util/CommonAppBar.dart';

import '../model/VeteranUser.dart';

import '../view/AccountPage.dart';
import '../view/AboutPage.dart';
import '../view/EditSOSContactsPage.dart';
import '../view/SendSOSPage.dart';
import '../view/UnfinishedPage.dart';

class VeteranUserLandingPage extends StatefulWidget {

  final VeteranUser user;

  VeteranUserLandingPage({Key key, this.user}) : super(key: key);

  @override
  VeteranUserLandingPageState createState() => VeteranUserLandingPageState();
}

class VeteranUserLandingPageState extends State<VeteranUserLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar("Welcome!", false, context),
        body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                    "Select an Applet",
                    style: TextStyle(
                        fontSize: 36,
                        color: FOREGROUND_COLOR

                    )
                ),
              ),
              Expanded(
                  child: ListView(
                      children: <Widget>[
                        AbstractActivity.generateTable([
                          AbstractActivityDescriptor(
                              activityName: "View My Account",
                              iconImageURL: "lib/assets/default_user_icon.png",
                              resultingPage: AccountPage(user: widget.user)
                          ),
                          AbstractActivityDescriptor(
                              activityName: "Track Fluid Intake",
                              iconImageURL: "lib/assets/fluid_bottle.jpg",
                              resultingPage: UnfinishedPage()
                          ),
                          AbstractActivityDescriptor(
                              activityName: "Track Mood",
                              iconImageURL: "lib/assets/irked_smiley_face.jpg",
                              resultingPage: UnfinishedPage()
                          ),
                          AbstractActivityDescriptor(
                              activityName: "Edit S.O.S. Contacts",
                              iconImageURL: "lib/assets/warning.png",
                              resultingPage: EditSOSContactsPage(user: widget.user)
                          ),
                          AbstractActivityDescriptor(
                              activityName: "About",
                              iconImageURL: "lib/assets/documents.png",
                              resultingPage: AboutPage()
                          )
                        ])
                      ]
                  )
              ),
              Container(
                  height: 50.0,
                  color: SOS_COLOR,
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return SendSOSPage(user: widget.user);
                          })),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                  Icons.announcement,
                                  size: 40.0,
                                  color: MAIN_TEXT_COLOR
                              ),
                            ),
                            Text(
                                "SEND AN S.O.S.",
                                style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: MAIN_TEXT_COLOR
                                )
                            )
                          ]
                      )
                  )
              )
            ]
        )
    );
  }
}