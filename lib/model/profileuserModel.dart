class ProfileUserModel {
  String? status;
  ProfileUserData? data;

  ProfileUserModel({this.status, this.data});

  ProfileUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? new ProfileUserData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileUserData {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? countryId;
  String? mobile;
  String? gender;
  String? address;
  String? website;
  String? phone;
  String? photo;
  String? photoStorage;
  String? userType;
  String? activeStatus;
  String? isEmailVerified;
  String? activationCode;
  String? isOnline;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;
  String? stripeId;
  String? cardBrand;
  String? cardLastFour;
  String? trialEndsAt;
  String? googleId;
  String? facebookId;
  String? apiToken;
  String? otp;
  String? contactVerified;

  ProfileUserData(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.userName,
      this.email,
      this.countryId,
      this.mobile,
      this.gender,
      this.address,
      this.website,
      this.phone,
      this.photo,
      this.photoStorage,
      this.userType,
      this.activeStatus,
      this.isEmailVerified,
      this.activationCode,
      this.isOnline,
      this.lastLogin,
      this.createdAt,
      this.updatedAt,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.trialEndsAt,
      this.googleId,
      this.facebookId,
      this.apiToken,
      this.otp,
      this.contactVerified});

  ProfileUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    email = json['email'];
    countryId = json['country_id'];
    mobile = json['mobile'];
    gender = json['gender'];
    address = json['address'];
    website = json['website'];
    phone = json['phone'];
    photo = json['photo'];
    photoStorage = json['photo_storage'].toString();
    userType = json['user_type'];
    activeStatus = json['active_status'];
    isEmailVerified = json['is_email_verified'];
    activationCode = json['activation_code'];
    isOnline = json['is_online'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    cardBrand = json['card_brand'];
    cardLastFour = json['card_last_four'];
    trialEndsAt = json['trial_ends_at'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    apiToken = json['api_token'];
    otp = json['otp'];
    contactVerified = json['contact_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['country_id'] = this.countryId;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['photo_storage'] = this.photoStorage;
    data['user_type'] = this.userType;
    data['active_status'] = this.activeStatus;
    data['is_email_verified'] = this.isEmailVerified;
    data['activation_code'] = this.activationCode;
    data['is_online'] = this.isOnline;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['card_brand'] = this.cardBrand;
    data['card_last_four'] = this.cardLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['api_token'] = this.apiToken;
    data['otp'] = this.otp;
    data['contact_verified'] = this.contactVerified;
    return data;
  }
}
