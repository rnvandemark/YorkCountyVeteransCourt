import '../util/AbstractUser.dart';

class VeteranUser extends AbstractUser {

  String phoneNumber;

  VeteranUser(
      int uniqueID,
      String email,
      String password,
      String firstName,
      String lastName,
      {this.phoneNumber})
      : super(uniqueID, email, password, firstName, lastName);

  String getPhoneNumber() {
    return this.phoneNumber;
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }
}