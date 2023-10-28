import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/model/notificationlist.dart';
import 'package:congobonmarche/model/ourpackageModel.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationListModel notificationModel = NotificationListModel();

  List<NotificationData> _notificationlist = [];
  List<NotificationData> get notificationList => _notificationlist;
  bool notificationfetch = false;

  Future notificationldatalist() async {
    print("object data");
    ServiceWithHeader _service =
        new ServiceWithHeader(NotificationPACKAGE + "?id=${MyApp.userid}");
    final response = await _service.data();
    print(response);
    notificationfetch = false;

    notificationModel = NotificationListModel.fromJson(response);
    if (notificationModel.notificaiondata != null) {
      if (notificationModel.notificaiondata!.length > 0) {
        print(notificationModel.notificaiondata!.length);

        _notificationlist = [];
        for (int i = 0; i < notificationModel.notificaiondata!.length; i++) {
          _notificationlist.add(notificationModel.notificaiondata![i]);
        }
        notificationfetch = true;
      } else {
        notificationfetch = true;
      }
    } else {
      print("ok");
      notificationfetch = true;
    }
    notifyListeners();

    return;
  }
}
