import '../util/AbstractUser.dart';

class VeteranUser extends AbstractUser {

  final String phoneNumber;

  VeteranUser(
      int uniqueID,
      String email,
      String password,
      String firstName,
      String lastName,
      {this.phoneNumber})
      : super(uniqueID, email, password, firstName, lastName);
}