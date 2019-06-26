import '../util/SOSContact.dart';

class ExternalSOSContact extends SOSContact {

  final String title;
  final String email;
  final String phoneNumber;
  final String iconURL;

  const ExternalSOSContact(
      int ownerID, {
        this.title,
        this.email,
        this.phoneNumber,
        this.iconURL
      }) : super(ownerID: ownerID);

  @override
  String getFullTitle() {
    return this.title;
  }

  @override
  List<SOSContactCapability> getCapabilities() {
    List<SOSContactCapability> capabilities = [];

    if (this.phoneNumber.isNotEmpty) {
      capabilities.add(SOSContactCapability.PHONE_CALL);
      capabilities.add(SOSContactCapability.PHONE_SMS);
    }

    if (this.email.isNotEmpty) {
      capabilities.add(SOSContactCapability.EMAIL);
    }

    return capabilities;
  }

}