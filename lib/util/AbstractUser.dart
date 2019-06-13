abstract class AbstractUser {

  int uniqueID;
  String email;
  String password;
  String firstName;
  String lastName;

  AbstractUser(
      this.uniqueID,
      this.email,
      this.password,
      this.firstName,
      this.lastName);

  bool checkLogin(String providedEmail, String providedPassword) {
    return (this.email == providedEmail) && (this.password == providedPassword);
  }
}