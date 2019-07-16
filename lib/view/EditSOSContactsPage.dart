import 'package:flutter/material.dart';

import '../db/DatabaseAccessor.dart';

import '../model/VeteranUser.dart';

import '../util/References.dart';
import '../util/CommonAppBar.dart';
import '../util/SOSContact.dart';

import '../view/EditSpecificSOSContactPage.dart';

class EditSOSContactsPage extends StatefulWidget {

  final VeteranUser user;

  EditSOSContactsPage({Key key, this.user}) : super(key: key);

  @override
  EditSOSContactsPageState createState() => EditSOSContactsPageState();
}

class EditSOSContactsPageState extends State<EditSOSContactsPage> {

  @override
  Widget build(BuildContext context) {
    Container addContactContainer = Container(
        height: 50.0,
        color: FOREGROUND_COLOR,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_circle,
                color: MAIN_TEXT_COLOR,
                size: 40.0,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                      "Add Contact",
                      style: TextStyle(
                          color: MAIN_TEXT_COLOR,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                      )
                  )
              )
            ]
        )
    );

    List<SOSContact> userSOSContacts = db.getSOSContactsFor(widget.user.uniqueID);
    Widget pageBody;

    if (userSOSContacts.isEmpty) {
      pageBody = Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                "No S.O.S. contacts found!",
                                style: TextStyle(
                                    fontSize: 42,
                                    color: FOREGROUND_COLOR
                                ),
                                textAlign: TextAlign.center,
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                  "Click the \"Add Contact\" button below to add one.",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: SECONDARY_COLOR
                                  ),
                                  textAlign: TextAlign.center
                              )
                          )
                        ]
                    )
                ),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      addContactContainer
                    ]
                )
              ]
          )
      );
    } else {
      pageBody = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                    "Select a Contact to Edit",
                    style: TextStyle(
                        color: FOREGROUND_COLOR,
                        fontSize: 36
                    )
                )
            ),
            Expanded(
                child: ListView(
                    children: SOSContactEditOptionWidget.generateListOf(
                        userSOSContacts,
                        context
                    )
                )
            ),
            addContactContainer
          ]
      );
    }

    return Scaffold(
        appBar: CommonAppBar("Edit S.O.S. Contacts", true, context),
        body: pageBody
    );
  }

}

class SOSContactEditOptionWidget extends GestureDetector {

  static final double iconSize = 38.0;
  static final TextStyle contactTitleTextStyle = TextStyle(
      color: FOREGROUND_COLOR,
      fontSize: 32
  );

  SOSContactEditOptionWidget({
    Key key,
    SOSContact contact,
    BuildContext context
  }) : super(
      key: key,
      child: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: generateChildren(contact)
          )
      ),
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute<Null>(builder: (BuildContext context) {
            return EditSpecificSOSContactPage(contact: contact);
          }))
  );

  static List<SOSContactEditOptionWidget> generateListOf(
      List<SOSContact> userSOSContacts,
      BuildContext context) {
    List<SOSContactEditOptionWidget> widgets = List<SOSContactEditOptionWidget>();

    for (SOSContact contact in userSOSContacts) {
      widgets.add(SOSContactEditOptionWidget(
          contact: contact, context: context
      ));
    }

    return widgets;
  }

  static List<Widget> generateChildren(SOSContact contact) {
    List<Widget> capabilityWidgets = List<Widget>();
    List<SOSContactCapability> capabilities = contact.getCapabilities();

    if (capabilities.contains(SOSContactCapability.IN_APP_CALL)) {
      capabilityWidgets.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(IN_APP_CALL_ICON)
      ));
    }

    if (capabilities.contains(SOSContactCapability.PHONE_CALL)) {
      capabilityWidgets.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(PHONE_CALL_ICON)
      ));
    }

    if (capabilities.contains(SOSContactCapability.PHONE_SMS)) {
      capabilityWidgets.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(PHONE_SMS_ICON)
      ));
    }

    if (capabilities.contains(SOSContactCapability.EMAIL)) {
      capabilityWidgets.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(EMAIL_ICON)
      ));
    }

    return [
      Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                    contact.getFullTitle(),
                    style: contactTitleTextStyle,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis
                )
            )
          ]
      ),
      Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          children: capabilityWidgets
      )
    ];
  }

}