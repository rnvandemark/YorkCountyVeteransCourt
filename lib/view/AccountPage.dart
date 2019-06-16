import 'package:flutter/material.dart';

import '../util/AbstractUser.dart';
import '../util/CommonAppBar.dart';

class AccountPage extends StatefulWidget {

  final AbstractUser user;

  AccountPage({Key key, this.user}) : super(key: key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar("My Account", true, context),
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "lib/assets/default_user_icon.png",
                      fit: BoxFit.contain
                    )
                  ),
                  SizedBox(height: 45.0),
                  Text(
                    '${widget.user.firstName} ${widget.user.lastName}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold)
                  )
                ]
              )
            )
          )
        )
    );
  }
}