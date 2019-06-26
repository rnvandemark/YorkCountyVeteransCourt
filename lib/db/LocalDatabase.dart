import '../db/AbstractDatabase.dart';

import '../model/VeteranUser.dart';
import '../model/InternalSOSContact.dart';
import '../model/ExternalSOSContact.dart';

import '../util/SOSContact.dart';

class LocalDatabase extends AbstractDatabase {

  LocalDatabase();

  @override
  void initialize() {
    veteranUsersRegistrar = List<VeteranUser>();

    int id = 0;

    veteranUsersRegistrar.add(VeteranUser(
        ++id,
        "example_nickvandy@gmail.com",
        "P455W0RD",
        "Nick",
        "Vandy",
        phoneNumber: "6102356766"
    ));

    veteranUsersRegistrar.add(VeteranUser(
        ++id,
        "example_robertvandemark@ycp.edu",
        "OTH3R_P455W0RD",
        "Robert",
        "Vandemark",
        phoneNumber: ""
    ));

    veteranUsersRegistrar.add(VeteranUser(
        ++id,
        "example_davefyfe@ycp.edu",
        "4NOTH3R_P455W0RD",
        "Dave",
        "Fyfe",
        phoneNumber: "7175550123"
    ));

    veteranUsersRegistrar.add(VeteranUser(
        ++id,
        "example_billyamtmann@ycp.edu",
        "Y3T_4NOTH3R_P455W0RD",
        "Billy",
        "Amtmann",
        phoneNumber: ""
    ));

    sosContactsRegistrar = List<SOSContact>();

    // Give Nick Vandy SOS Contacts of: Dave Fyfe and Billy Amtmann
    sosContactsRegistrar.add(InternalSOSContact(
        1, contact: veteranUsersRegistrar[2]
    ));
    sosContactsRegistrar.add(InternalSOSContact(
        1, contact: veteranUsersRegistrar[3]
    ));

    // Give Robert Vandemark no SOS Contacts

    // Give Dave Fyfe an SOS Contact of Robert Vandemark
    sosContactsRegistrar.add(InternalSOSContact(
        3, contact: veteranUsersRegistrar[1]
    ));

    // Give Billy Amtmann an SOS Contact of Robert Vandemark
    sosContactsRegistrar.add(InternalSOSContact(
        4, contact: veteranUsersRegistrar[1]
    ));

    // Give Nick Vandy an SOS Contact of Mom
    sosContactsRegistrar.add(ExternalSOSContact(
      1,
      title: "Ma Vandemark",
      email: "example_mavandemark@gmail.com",
      phoneNumber: "4845550124"
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

  @override
  List<SOSContact> getSOSContactsFor(int userId) {
    List<SOSContact> contacts = List<SOSContact>();

    for (SOSContact contact in sosContactsRegistrar) {
      if (contact.ownerID == userId) {
        contacts.add(contact);
      }
    }

    return contacts;
  }
}