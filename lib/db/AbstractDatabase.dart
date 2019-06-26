import 'dart:core';

import '../db/DatabaseInterface.dart';
import '../model/VeteranUser.dart';
import '../util/SOSContact.dart';

abstract class AbstractDatabase implements DatabaseInterface {

  List<VeteranUser> veteranUsersRegistrar;
  List<SOSContact> sosContactsRegistrar;

}