import 'dart:core';

import '../model/VeteranUser.dart';
import '../util/SOSContact.dart';

abstract class DatabaseInterface {

  void initialize();
  VeteranUser validateUserCredentials(String email, String password);
  List<SOSContact> getSOSContactsFor(int userId);
  bool changeAbstractUserInfo(int userId, String newFirstName, String newLastName, String newEmail);
  String getAbstractUserFirstName(int userId);
  String getAbstractUserLastName(int userId);
  String getAbstractUserEmail(int userId);
}