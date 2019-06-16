import 'package:flutter/material.dart';

import '../util/References.dart';

class CommonAppBar extends AppBar {

  static TextTheme commonTextTheme = TextTheme(
      title: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 24,
          color: MAIN_TEXT_COLOR
      )
  );

  CommonAppBar(String title, bool implyLeading, BuildContext context) : super(
      automaticallyImplyLeading: implyLeading,
      title: Text(title),
      textTheme: commonTextTheme,
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
  );
}