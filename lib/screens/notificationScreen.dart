import 'package:congobonmarche/model/notificationlist.dart';
import 'package:congobonmarche/provider/notificationprovider.dart';
import 'package:congobonmarche/screens/notificationshowpop.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/contants.dart';
import 'package:congobonmarche/utils/screen/appbar.dart';
import 'package:congobonmarche/utils/screen/loader.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationProvider _notificationProvider = NotificationProvider();
  NotificationData? notificationData;
  bool showpop = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    _notificationProvider.notificationldatalist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarScreen(title: 'Notification')),
      body: Consumer<NotificationProvider>(
          builder: (context, notification, child) {
        print(notification.notificationModel.status);
        if (!notification.notificationfetch) {
          return LoaderScreen();
        }

        if (notification.notificationfetch) {
          if (notification.notificationList.isEmpty) {
            return Center(
                child: Text(
              "Aucune donnée disponible",
              style: Style_File.title,
            ));
          }
        }
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            ListView.builder(
                // shrinkWrap: true,
                itemCount: notification.notificationList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showpop = true;
                          notificationData =
                              notification.notificationList[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorWhite,
                          // border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(2.w),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.notificationList[index].title!,
                                style: Style_File.title,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                notification.notificationList[index].body!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Style_File.subtitle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat(" dd-MM-yyyy").format(
                                        DateTime.parse(notification
                                            .notificationList[index]
                                            .createdAt!)),
                                    style: Style_File.subtitle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            if (showpop)
              Container(
                height: 100.h,
                width: 100.w,
                color: Colors.transparent,
                child: NotificationpopScreen(
                  notificationData: notificationData,
                  callback: (value) {
                    print(value);
                    setState(() {
                      showpop = false;
                    });
                  },
                ),
              ),
          ],
        );
      }),
    );
  }
}
