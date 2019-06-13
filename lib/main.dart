import 'package:flutter/material.dart';

import 'view/LoginPage.dart';
import 'util/References.dart';

void main() => runApp(VeteransCourtApp());

// The root of the application.
class VeteransCourtApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(primarySwatch: FOREGROUND_COLOR),
      home: LoginPage(title: APP_TITLE),
    );
  }
}