import 'dart:core';

import '../db/DatabaseInterface.dart';
import '../model/VeteranUser.dart';

abstract class AbstractDatabase implements DatabaseInterface {

  List<VeteranUser> veteranUsersRegistrar;
}