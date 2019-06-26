import 'package:flutter/material.dart';

import '../util/CommonAppBar.dart';

class AboutPage extends StatefulWidget {

  final TextStyle tileTitleStyle = TextStyle(
    fontSize: 24,
    color: Colors.black
  );

  AboutPage({Key key}) : super(key: key);

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar("About This App", true, context),
        body: Column(
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: ExpansionTile(
                  title: Text(
                      "Inspiration for the App",
                      style: widget.tileTitleStyle
                  ),
                  children: <Widget>[

                  ]
              )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: ExpansionTile(
                    title: Text(
                        "The End-User License Agreement",
                        style: widget.tileTitleStyle
                    ),
                    children: <Widget>[

                    ]
                )
            ),
            Padding(
                padding: EdgeInsets.only(),
                child: ExpansionTile(
                    title: Text(
                        "What Information of Yours is Public and Private",
                        style: widget.tileTitleStyle
                    ),
                    children: <Widget>[

                    ]
                )
            )
          ]
        )
    );
  }
}