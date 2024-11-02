import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/notification.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/bottom_navbar.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/widgets/notifications/notifications_message_box.dart';
import 'package:bakingup_frontend/widgets/notifications/notifications_message_section_loading.dart';
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
  bool noResult = false;

  Future<void> _getAllNotifications() async {
    setState(() {
      isLoading = true;
      isError = false;
      notiList = [];
      noResult = false;
      date = "";
    });

    try {
      final response = await NetworkService.instance
          .get('/api/noti/getAllNotifications?user_id=1');

      final notiResponse = NotificationsResponse.fromJson(response);
      final data = notiResponse.data;
      setState(() {
        notiList = data.notis;

        if (notiResponse.status == 200 && notiList.isEmpty) {
          noResult = true;
        }
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

  Future<void> _deleteNotification(String notiId) async {
    showDialog(
      context: context,
      barrierColor: greyColor,
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );
    await NetworkService.instance
        .delete('/api/noti/deleteNotification?noti_id=$notiId');

    if (notiList.length == 1) {
      _getAllNotifications();
    } else {
      setState(() {
        notiList.removeWhere((noti) => noti.notiID == notiId);
      });
    }
  }

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
          .put('/api/noti/readNotification?noti_id=$notiID');
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
          : noResult
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BakingUpNoResult(
                          message: "You currently have no notifications")
                    ],
                  ),
                )
              : isLoading
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const NotificationMessageSectionLoading();
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      itemCount: notiList.length,
                      itemBuilder: (context, index) {
                        List<Widget> widgets = [];

                        NotificationItem item = notiList[index];
                        String currentDate = item.createdAt.substring(0, 10);

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

                        widgets.add(Dismissible(
                            key: Key(notiList[index].notiID),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              padding: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: redColor,
                              ),
                              alignment: Alignment.centerLeft,
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BakingUpDialog(
                                      title: "Confirm Delete?",
                                      imgUrl: "assets/icons/delete_warning.png",
                                      content:
                                          "Are you sure you want to delete this notification?",
                                      grayButtonTitle: "Cancel",
                                      secondButtonTitle: "Delete",
                                      secondButtonColor: lightRedColor,
                                      grayButtonOnClick: () {
                                        Navigator.pop(context);
                                      },
                                      secondButtonOnClick: () {
                                        Navigator.of(context).pop();
                                        _deleteNotification(
                                                notiList[index].notiID)
                                            .then((_) {
                                          Navigator.of(context).pop();
                                        }).catchError((error) {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .overlay!
                                              .insert(OverlayEntry(
                                            builder: (BuildContext context) {
                                              return const BakingUpErrorTopNotification(
                                                message:
                                                    "Sorry, we couldn’t delete the notification due to a system error. Please try again later.",
                                              );
                                            },
                                          ));
                                        });
                                      },
                                    );
                                  });
                            },
                            child: NotificationsMessageBox(
                              noti: item,
                              readFunction: _readNotification,
                              fetchAllNotis: _getAllNotifications,
                            )));

                        return Column(children: widgets);
                      },
                    ),
    );
  }
}
