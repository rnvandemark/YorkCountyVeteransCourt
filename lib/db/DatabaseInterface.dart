import '../model/VeteranUser.dart';

abstract class DatabaseInterface {
  void populateVeteranUsers();
  VeteranUser validateUserCredentials(String email, String password);
}