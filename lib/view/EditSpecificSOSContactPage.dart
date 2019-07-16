import 'package:flutter/material.dart';

import '../model/InternalSOSContact.dart';
import '../model/ExternalSOSContact.dart';
import '../model/VeteranUser.dart';

import '../util/References.dart';
import '../util/CommonAppBar.dart';
import '../util/SOSContact.dart';

class EditSpecificSOSContactPage extends StatefulWidget {

  final SOSContact contact;

  EditSpecificSOSContactPage({Key key, this.contact}) : super(key: key);

  @override
  EditSpecificSOSContactPageState createState() => EditSpecificSOSContactPageState();
}

class EditSpecificSOSContactPageState extends State<EditSpecificSOSContactPage> {

  static final double elementPadding = 15.0;

  static final double capabilityIconSize = 38.0;

  static final TextStyle capabilityDescription = TextStyle(
      fontSize: 20
  );

  static final TextStyle modificationText = TextStyle(
      fontSize: 14,
      color: Colors.grey
  );

  TextEditingController dialogController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar("Edit S.O.S. Contact", true, context),
        body: ListView(
            children: getAppropriatePageWidgets()
        )
    );
  }

  List<Widget> getAppropriatePageWidgets() {
    List<Widget> pageWidgets = List<Widget>();

    pageWidgets.add(
        Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: elementPadding),
                  child: SizedBox(
                      height: 155.0,
                      child: Image.asset(
                          "lib/assets/default_user_icon.png",
                          fit: BoxFit.contain
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: elementPadding,
                      bottom: elementPadding
                  ),
                  child: Text(
                      widget.contact.getFullTitle(),
                      style: TextStyle(
                          fontSize: 34,
                          color: FOREGROUND_COLOR
                      )
                  )
              )
            ]
        )
    );

    final Column editCapabilitiesList = Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>()
    );

    final bool isInternalContact = widget.contact is InternalSOSContact;
    if (!isInternalContact) {
      assert(widget.contact is ExternalSOSContact);
    }

    final List<SOSContactCapability> contactCapabilities = widget.contact.getCapabilities();

    //
    // Do logic for In-App call capabilities
    //

    final Row rowInAppCall = Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: List<Widget>()
    );
    if (contactCapabilities.contains(SOSContactCapability.IN_APP_CALL)) {
      rowInAppCall.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: Icon(
                  IN_APP_CALL_ICON,
                  size: capabilityIconSize,
                  color: Colors.green
              )
          )
      );
      rowInAppCall.children.add(
          Text(
              "In-App Call is available.",
              style: TextStyle(
                  fontSize: 20
              )
          )
      );
    } else {
      rowInAppCall.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: Icon(
                  IN_APP_CALL_ICON,
                  size: capabilityIconSize,
                  color: Colors.red
              )
          )
      );
      rowInAppCall.children.add(
          Text(
              "In-App Call is unavailable.",
              style: capabilityDescription
          )
      );
    }
    editCapabilitiesList.children.add(Padding(
        padding: EdgeInsets.only(
            top: elementPadding,
            left: elementPadding,
            right: elementPadding
        ),
        child: rowInAppCall
    ));

    //
    // Do logic for Phone call capabilities
    //

    String phoneNumberString;
    if (isInternalContact) {
      // This is a temporary assertion, until more than VeteranUsers are supported
      assert((widget.contact as InternalSOSContact).contact is VeteranUser);
      phoneNumberString = (
          (widget.contact as InternalSOSContact).contact as VeteranUser
      ).phoneNumber;
    } else {
      phoneNumberString = (
          (widget.contact as ExternalSOSContact)
      ).phoneNumber;
    }

    if (phoneNumberString.length == 10) {
      phoneNumberString = "("
          + phoneNumberString.substring(0, 3)
          + ") "
          + phoneNumberString.substring(3, 6)
          + " - "
          + phoneNumberString.substring(6);
    }

    final Row rowPhoneCall = Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: List<Widget>()
    );
    if (contactCapabilities.contains(SOSContactCapability.PHONE_CALL)) {
      rowPhoneCall.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: Icon(
                  PHONE_CALL_ICON,
                  size: capabilityIconSize,
                  color: Colors.green
              )
          )
      );
      rowPhoneCall.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: GestureDetector(
                  child: Column(
                      children: <Widget> [
                        Icon(
                            Icons.edit,
                            color: Colors.green
                        ),
                        Text(
                            "Edit",
                            style: modificationText
                        )
                      ]
                  ),
                  onTap: () => showPhoneNumberDialog(
                      "Phone Number",
                      r'(^(?:[+0]9)?[0-9]{10,12}$)'
                  )
              )

          )
      );

      rowPhoneCall.children.add(
          Text(
              phoneNumberString,
              style: capabilityDescription
          )
      );
    } else {
      rowPhoneCall.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: Icon(
                  PHONE_CALL_ICON,
                  size: capabilityIconSize,
                  color: Colors.red
              )
          )
      );
      rowPhoneCall.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: GestureDetector(
                  child: Column(
                      children: <Widget> [
                        Icon(
                            Icons.add_circle,
                            color: Colors.red
                        ),
                        Text(
                            "Add",
                            style: modificationText
                        )
                      ]
                  ),
                  onTap: () => showPhoneNumberDialog(
                      "Phone Number",
                      r'(^(?:[+0]9)?[0-9]{10,12}$)'
                  )
              )

          )
      );
      rowPhoneCall.children.add(
          Text(
              "No phone number on record.",
              style: capabilityDescription
          )
      );
    }
    editCapabilitiesList.children.add(Padding(
        padding: EdgeInsets.only(
            top: elementPadding,
            left: elementPadding,
            right: elementPadding
        ),
        child: rowPhoneCall
    ));

    final Row rowPhoneSMS = Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: List<Widget>()
    );
    if (contactCapabilities.contains(SOSContactCapability.PHONE_SMS)) {
      rowPhoneSMS.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: Icon(
                  PHONE_SMS_ICON,
                  size: capabilityIconSize,
                  color: Colors.green
              )
          )
      );
      rowPhoneSMS.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: GestureDetector(
                  child: Column(
                      children: <Widget> [
                        Icon(
                            Icons.edit,
                            color: Colors.green
                        ),
                        Text(
                            "Edit",
                            style: modificationText
                        )
                      ]
                  ),
                  onTap: () => showPhoneNumberDialog(
                      "Phone Number",
                      r'(^(?:[+0]9)?[0-9]{10,12}$)'
                  )
              )

          )
      );

      rowPhoneSMS.children.add(
          Text(
              phoneNumberString,
              style: capabilityDescription
          )
      );
    } else {
      rowPhoneSMS.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: Icon(
                  PHONE_SMS_ICON,
                  size: capabilityIconSize,
                  color: Colors.red
              )
          )
      );
      rowPhoneSMS.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: GestureDetector(
                  child: Column(
                      children: <Widget> [
                        Icon(
                            Icons.add_circle,
                            color: Colors.red
                        ),
                        Text(
                            "Add",
                            style: modificationText
                        )
                      ]
                  ),
                  onTap: () => showPhoneNumberDialog(
                    "Phone Number",
                    r'(^(?:[+0]9)?[0-9]{10,12}$)'
                  )
              )

          )
      );
      rowPhoneSMS.children.add(
          Text(
              "No phone number on record.",
              style: capabilityDescription
          )
      );
    }
    editCapabilitiesList.children.add(Padding(
        padding: EdgeInsets.only(
            top: elementPadding,
            left: elementPadding,
            right: elementPadding
        ),
        child: rowPhoneSMS
    ));

    final Row rowEmail = Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: List<Widget>()
    );
    if (contactCapabilities.contains(SOSContactCapability.EMAIL)) {
      String emailString;
      if (isInternalContact) {
        // This is a temporary assertion, until more than VeteranUsers are supported
        assert((widget.contact as InternalSOSContact).contact is VeteranUser);
        emailString = (
            (widget.contact as InternalSOSContact).contact as VeteranUser
        ).email;
      } else {
        emailString = (
            (widget.contact as ExternalSOSContact)
        ).email;
      }

      rowEmail.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: Icon(
                  EMAIL_ICON,
                  size: capabilityIconSize,
                  color: Colors.green
              )
          )
      );
      rowEmail.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: GestureDetector(
                  child: Column(
                      children: <Widget> [
                        Icon(
                            Icons.edit,
                            color: Colors.green
                        ),
                        Text(
                            "Edit",
                            style: modificationText
                        )
                      ]
                  ),
                  onTap: () => showPhoneNumberDialog(
                      "Email",
                      ""
                  )
              )

          )
      );

      rowEmail.children.add(
          Flexible(
            child: Text(
                emailString,
                style: capabilityDescription,
                overflow: TextOverflow.ellipsis
            )
          )
      );
    } else {
      rowEmail.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: Icon(
                  EMAIL_ICON,
                  size: capabilityIconSize,
                  color: Colors.red
              )
          )
      );
      rowEmail.children.add(
          Padding(
              padding: EdgeInsets.only(right: elementPadding),
              child: GestureDetector(
                  child: Column(
                      children: <Widget> [
                        Icon(
                            Icons.add_circle,
                            color: Colors.red
                        ),
                        Text(
                            "Add",
                            style: modificationText
                        )
                      ]
                  ),
                  onTap: () => showPhoneNumberDialog(
                    "Email",
                    ""
                  )
              )
          )
      );
      rowEmail.children.add(
          Text(
              "No email on record.",
              style: capabilityDescription
          )
      );
    }
    editCapabilitiesList.children.add(Padding(
        padding: EdgeInsets.only(
            top: elementPadding,
            left: elementPadding,
            right: elementPadding
        ),
        child: rowEmail
    ));

    pageWidgets.add(editCapabilitiesList);

    return pageWidgets;
  }

  showPhoneNumberDialog(String text, String regex) async {
    dialogController = TextEditingController();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AnimatedAlertDialog(
              child: AlertDialog(
                  contentPadding: const EdgeInsets.all(16.0),
                  content: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                    labelText: "",
                                    hintText: text
                                ),
                                controller: dialogController
                            )
                        )
                      ]
                  ),
                  actions: <Widget>[
                    FlatButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          dialogController = null;
                          Navigator.pop(context);
                        }
                    ),
                    FlatButton(
                        child: const Text('DELETE'),
                        onPressed: () {
                          dialogController = null;
                          Navigator.pop(context);
                        }
                    ),
                    FlatButton(
                        child: const Text('SAVE'),
                        onPressed: () {
                          String modifiedNumber = dialogController.text;
                          RegExp regExpression = RegExp(regex);
                          if ((modifiedNumber.length > 0)
                              && (regExpression.hasMatch(modifiedNumber))) {
                            print("Match: " + modifiedNumber);
                          }
                          dialogController = null;
                          Navigator.pop(context);
                        }
                    )
                  ]
              )
          );
        }
    );
  }
}

class AnimatedAlertDialog extends StatelessWidget {

  final Widget child;

  AnimatedAlertDialog({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AnimatedContainer(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 200),
        child: child
    );
  }
}