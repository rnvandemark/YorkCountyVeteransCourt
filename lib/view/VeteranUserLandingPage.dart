import 'package:flutter/material.dart';

import '../util/References.dart';
import '../model/VeteranUser.dart';

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
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Welcome!'),
            textTheme: new TextTheme(
              title: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                color: MAIN_TEXT_COLOR
              )
            ),
            actions: <Widget>[
              // action button
              IconButton(
                  icon: Icon(
                      Icons.exit_to_app,
                      size: 40.0,
                      color: MAIN_TEXT_COLOR
                  ),
                  onPressed: () {
                    Navigator.maybePop(context);
                  }
              )
            ]
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  // Fill with activities scroller
                  return new ListTile(title: new Text("Option #$index (soon to be developed.)"));
                }
              )
            ),
            new Container(
              height: 50.0,
              color: SOS_COLOR,
              child: new GestureDetector(
                  onTap: () => debugPrint('[Navigating to S.O.S. page!]'),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                          Icons.announcement,
                          size: 40.0,
                          color: MAIN_TEXT_COLOR
                      ),
                      new SizedBox(width: 10.0),
                      new Text(
                          "SEND AN S.O.S.",
                          style: new TextStyle(
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