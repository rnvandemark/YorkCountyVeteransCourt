import 'package:flutter/material.dart';

import '../db/DatabaseAccessor.dart';

import '../view/UnfinishedPage.dart';

import '../model/VeteranUser.dart';

import '../util/References.dart';
import '../util/CommonAppBar.dart';
import '../util/SOSContact.dart';

class SendSOSPage extends StatefulWidget {

  final VeteranUser user;

  SendSOSPage({Key key, this.user}) : super(key: key);

  @override
  SendSOSPageState createState() => SendSOSPageState();
}

class SendSOSPageState extends State<SendSOSPage> {

  static final List<Widget> noneBanner = [
    Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Text(
            "You don't have any S.O.S. contacts!",
            style: TextStyle(
                fontSize: 42,
                color: FOREGROUND_COLOR
            ),
            textAlign: TextAlign.center
        )
    ),
    Text(
        "You can add some through the \"Edit S.O.S. Contacts\" applet.",
        style: TextStyle(
            fontSize: 24,
            color: SECONDARY_COLOR
        ),
        textAlign: TextAlign.center
    )
  ];

  static final TextStyle styleSOSContactName = TextStyle(
      fontSize: 32,
      color: FOREGROUND_COLOR
  );

  static final TextStyle actionWidgetName = TextStyle(
      fontSize: 14,
      color: Colors.grey
  );

  static final double actionWidgetPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar("SOS Contacts", true, context),
        body: Center(
            child: getAppropriateContent(
                db.getSOSContactsFor(widget.user.uniqueID),
                context
            )
        )
    );
  }

  Widget getAppropriateContent(
      List<SOSContact> userSOSContacts,
      BuildContext context) {
    Widget result;

    if (userSOSContacts.isNotEmpty) {
      result = ListView(
          children: generateContactWidgets(userSOSContacts, context)
      );
    } else {
      result = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: noneBanner
      );
    }

    return result;
  }

  List<Widget> generateContactWidgets(
      List<SOSContact> userSOSContacts,
      BuildContext context) {
    List<Widget> contactWidgets = List<Widget>();

    for (SOSContact contact in userSOSContacts) {
      contactWidgets.add(
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        contact.getFullTitle(),
                        style: styleSOSContactName,
                        overflow: TextOverflow.ellipsis
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: generateActionWidgets(
                                contact.getCapabilities(),
                                context
                            )
                        )
                    )
                  ]
              )
          )
      );
    }

    return contactWidgets;
  }

  List<Widget> generateActionWidgets(
      List<SOSContactCapability> capabilities,
      BuildContext context) {
    List<Widget> actionWidgets = List<Widget>();

    if (capabilities.indexOf(SOSContactCapability.IN_APP_CALL) >= 0) {
      actionWidgets.add(Padding(
          padding: EdgeInsets.only(
              left: actionWidgetPadding,
              right: actionWidgetPadding
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.phonelink_ring),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return UnfinishedPage();
                        })
                    )
                ),
                Text(
                  "In-App Call",
                  style: actionWidgetName,
                )
              ]
          )
      ));
    }

    if (capabilities.indexOf(SOSContactCapability.PHONE_CALL) >= 0) {
      actionWidgets.add(Padding(
          padding: EdgeInsets.only(
              left: actionWidgetPadding,
              right: actionWidgetPadding
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return UnfinishedPage();
                        })
                    )
                ),
                Text(
                  "Phone Call",
                  style: actionWidgetName,
                )
              ]
          )
      ));
    }

    if (capabilities.indexOf(SOSContactCapability.PHONE_SMS) >= 0) {
      actionWidgets.add(Padding(
          padding: EdgeInsets.only(
              left: actionWidgetPadding,
              right: actionWidgetPadding
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return UnfinishedPage();
                        })
                    )
                ),
                Text(
                  "Phone Text",
                  style: actionWidgetName,
                )
              ]
          )
      ));
    }

    if (capabilities.indexOf(SOSContactCapability.EMAIL) >= 0) {
      actionWidgets.add(Padding(
          padding: EdgeInsets.only(
              left: actionWidgetPadding,
              right: actionWidgetPadding
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.email),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return UnfinishedPage();
                        })
                    )
                ),
                Text(
                  "Email",
                  style: actionWidgetName,
                )
              ]
          )
      ));
    }

    return actionWidgets;
  }

}