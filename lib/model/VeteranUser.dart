import '../util/AbstractUser.dart';

class VeteranUser extends AbstractUser {

  VeteranUser(
      int uniqueID,
      String email,
      String password,
      String firstName,
      String lastName)
      : super(uniqueID, email, password, firstName, lastName);
}