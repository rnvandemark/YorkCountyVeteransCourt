import 'dart:core';

import '../model/VeteranUser.dart';
import '../util/SOSContact.dart';

abstract class DatabaseInterface {

  void initialize();
  VeteranUser validateUserCredentials(String email, String password);
  List<SOSContact> getSOSContactsFor(int userId);

}