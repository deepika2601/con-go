class NotificationListModel {
  String? status;
  String? message;
  List<NotificationData>? notificaiondata;

  NotificationListModel({this.status, this.message, this.notificaiondata});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      notificaiondata = <NotificationData>[];
      json['data'].forEach((v) {
        notificaiondata!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.notificaiondata != null) {
      data['data'] = this.notificaiondata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? userId;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;
  String? queryId;
  UserQuery? userQuery;

  NotificationData(
      {this.id,
      this.userId,
      this.title,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.queryId,
      this.userQuery});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    queryId = json['query_id'];
    userQuery = json['user_query'] != null
        ? new UserQuery.fromJson(json['user_query'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['query_id'] = this.queryId;
    if (this.userQuery != null) {
      data['user_query'] = this.userQuery!.toJson();
    }
    return data;
  }
}

class UserQuery {
  int? id;
  String? categoryId;
  String? userId;
  String? name;
  String? email;
  String? mobile;
  String? message;
  String? adId;
  String? createdAt;
  String? updatedAt;
  String? date;
  String? time;

  UserQuery(
      {this.id,
      this.categoryId,
      this.userId,
      this.name,
      this.email,
      this.mobile,
      this.message,
      this.adId,
      this.createdAt,
      this.updatedAt,
      this.date,
      this.time});

  UserQuery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    message = json['message'];
    adId = json['ad_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['message'] = this.message;
    data['ad_id'] = this.adId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
