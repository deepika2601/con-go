// ignore_for_file: unnecessary_new

import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';

class LoginApi {
  final Map<String, dynamic> body;
  LoginApi(this.body);

  Future register() async {
    Service service = new Service(REGISTRATION, body);
    var data = await service.formdata();

    return data;
  }

  Future login() async {
    Service service = new Service(LOGIN, body);
    var data = await service.formdata();
    return data;
  }

  Future fcmlogin() async {
    Service service = new Service(FCMTOKENRegister, body);
    var data = await service.formdata();
    return data;
  }

  Future fcmlogout() async {
    Service service = new Service(FCMTOKENlogout, body);
    var data = await service.formdata();

    return data;
  }

  Future fasebooklogin() async {
    Service service = new Service(Sociallogin, body);
    var data = await service.formdata();

    return data;
  }

  Future verifyOtp() async {
    Service service = new Service(VERIFYOTP, body);
    var data = await service.formdata();

    return data;
  }

  Future forgetverifyOtp() async {
    Service service = new Service(FORGETVERIFYOTP, body);
    var data = await service.formdata();

    return data;
  }

  Future forgetpassword() async {
    Service service = new Service(FORGETPASSWORD, body);
    var data = await service.formdata();

    return data;
  }

  Future setpassword() async {
    Service service = new Service(RESETPASSWORD, body);
    var data = await service.formdata();

    return data;
  }

  Future updateprofile() async {
    Service service = new Service(ProfileUpdate, body);
    var data = await service.formdata();

    return data;
  }

  Future sentquery() async {
    Service service = new Service(Sentquery, body);
    var data = await service.formdata();

    return data;
  }

  Future sendnotification() async {
    ServiceWithoutbody service = new ServiceWithoutbody(Sendnotification);
    var data = await service.datapost();

    return data;
  }

  Future address() async {
    Service service = new Service(AddAddress, body);
    var data = await service.formdata();

    return data;
  }

  Future addressupdate() async {
    Service service = new Service(UpdateAddress, body);
    var data = await service.formdata();

    return data;
  }

  Future addressdelete() async {
    Service service = new Service(DeleteAddress, body);
    var data = await service.formdata();

    return data;
  }

  Future createAds() async {
    Service service = new Service(AdsCreate, body);
    var data = await service.formdata();

    return data;
  }

  Future updateAds() async {
    Service service = new Service(UpdateAds, body);
    var data = await service.formdata();

    return data;
  }

  Future adsdelete() async {
    Service service = new Service(DeleteAds, body);
    var data = await service.formdata();

    return data;
  }

  Future helpsupport() async {
    Service service = new Service(HelpSuport, body);
    var data = await service.formdata();

    return data;
  }

  Future deleteacount() async {
    Service service = new Service(Deleteacount, body);
    var data = await service.formdata();

    return data;
  }

  Future sentreport() async {
    Service service = new Service(ReportAd, body);
    var data = await service.formdata();

    return data;
  }

  Future paymentupdate() async {
    Service service = new Service(Paymentupdate, body);
    var data = await service.formdata();

    return data;
  }
}
