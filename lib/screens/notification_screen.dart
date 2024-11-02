import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/notification.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/bottom_navbar.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_error.dart';
import 'package:bakingup_frontend/widgets/notifications/notifications_message_box.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notiList = [];
  bool isLoading = false;
  bool isError = false;
  String date = "";

  Future<void> _getAllNotifications() async {
    setState(() {
      isLoading = true;
      isError = false;
      notiList = [];
    });

    try {
      final response = await NetworkService.instance
          .get('/api/noti/getAllNotifications?user_id=1');

      final notiResponse = NotificationsResponse.fromJson(response);
      final data = notiResponse.data;

      setState(() {
        notiList = data.notis;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> _deleteNotification(String notiId) async {
  //   showDialog(
  //     context: context,
  //     barrierColor: greyColor,
  //     builder: (BuildContext context) {
  //       return const BakingUpLoadingDialog();
  //     },
  //   );
  //   await NetworkService.instance
  //       .delete('/api/noti/deleteNotification?noti_id=$notiId');
  // }

  Future<void> _readAllNotifications() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      await NetworkService.instance
          .put('/api/noti/readAllNotifications?user_id=1');

      _getAllNotifications();
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _readNotification(String notiID) async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      await NetworkService.instance
          .put('/api/noti/readNotification?noti=$notiID');
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _getAllNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: backgroundColor,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const BakingUpDrawer(),
      bottomNavigationBar: const BottomNavbar(),
      body: isError
          ? Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [BakingUpError()],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              itemCount: notiList.length,
              itemBuilder: (context, index) {
                NotificationItem item = notiList[index];
                String currentDate = item.createdAt.substring(0, 10);

                List<Widget> widgets = [];

                if (date != currentDate) {
                  date = currentDate;
                  widgets.add(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentDate,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            color: blackColor),
                      ),
                      index == 0
                          ? TextButton(
                              onPressed: _readAllNotifications,
                              child: Text(
                                'Mark all as Read',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor),
                              ))
                          : const SizedBox(),
                    ],
                  ));
                }

                widgets.add(NotificationsMessageBox(
                  noti: item,
                  readFunction: _readNotification,
                ));

                return Column(children: widgets);
              },
            ),
    );
  }
}
