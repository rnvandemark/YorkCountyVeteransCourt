import '../db/AbstractDatabase.dart';
import '../model/VeteranUser.dart';

class LocalDatabase extends AbstractDatabase {

  LocalDatabase();

  @override
  void populateVeteranUsers() {
    veteranUsersRegistrar = new List<VeteranUser>();

    int id = 0;

    veteranUsersRegistrar.add(new VeteranUser(
        ++id,
        "rnvandemark@gmail.com",
        "P455W0RD",
        "Nick",
        "Vandy"
    ));

    veteranUsersRegistrar.add(new VeteranUser(
        ++id,
        "rvandemark@ycp.edu",
        "OTH3R_P455W0RD",
        "Robert",
        "Vandemark"
    ));
  }

  @override
  VeteranUser validateUserCredentials(String email, String password) {
    for (VeteranUser vu in veteranUsersRegistrar) {
      if (vu.checkLogin(email, password)) {
        return vu;
      }
    }

    return null;
  }
}