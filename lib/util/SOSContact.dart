import 'dart:core';

enum SOSContactCapability {

  IN_APP_CALL,
  PHONE_CALL,
  PHONE_SMS,
  EMAIL

}

abstract class SOSContact {

  final int ownerID;

  const SOSContact({this.ownerID});

  String getFullTitle();
  List<SOSContactCapability> getCapabilities();

}