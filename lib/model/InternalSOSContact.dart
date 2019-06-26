import '../util/SOSContact.dart';
import '../util/AbstractUser.dart';
import 'VeteranUser.dart';

class InternalSOSContact extends SOSContact {

  final AbstractUser contact;

  const InternalSOSContact(int ownerID, {this.contact})
      : super(ownerID: ownerID);

  @override
  String getFullTitle() {
    return this.contact.firstName + " " + this.contact.lastName;
  }

  @override
  List<SOSContactCapability> getCapabilities() {
    List<SOSContactCapability> capabilities = [
      SOSContactCapability.IN_APP_CALL,
      SOSContactCapability.EMAIL
    ];

    if ((contact is VeteranUser)
        && ((contact as VeteranUser).phoneNumber.isNotEmpty)) {
      capabilities.add(SOSContactCapability.PHONE_CALL);
      capabilities.add(SOSContactCapability.PHONE_SMS);
    }

    return capabilities;
  }

}