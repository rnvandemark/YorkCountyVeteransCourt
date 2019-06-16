import 'package:flutter/material.dart';

import '../util/References.dart';
import '../util/CommonAppBar.dart';

class UnfinishedPage extends StatefulWidget {

  UnfinishedPage({Key key}) : super(key: key);

  @override
  UnfinishedPageState createState() => UnfinishedPageState();
}

class UnfinishedPageState extends State<UnfinishedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("Uh Oh!", true, context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Page Not Yet Supported",
                style: TextStyle(
                    fontSize: 42,
                    color: FOREGROUND_COLOR
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Check back in here later!",
              style: TextStyle(
                fontSize: 24,
                color: SECONDARY_COLOR
              )
            )
          ]
        )
      )
    );
  }
}