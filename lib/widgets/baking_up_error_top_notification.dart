import 'dart:async';

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpErrorTopNotification extends StatefulWidget {
  final String message;
  const BakingUpErrorTopNotification({super.key, required this.message});

  @override
  State<StatefulWidget> createState() => BakingUpErrorTopNotificationState();
}

class BakingUpErrorTopNotificationState
    extends State<BakingUpErrorTopNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    position = Tween<Offset>(
      begin: const Offset(0.0, -4.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceInOut,
      ),
    );

    controller.forward();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IgnorePointer(
        ignoring: true,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
              child: SlideTransition(
                position: position,
                child: Container(
                  decoration: ShapeDecoration(
                    color: errorLightRedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/error.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.message,
                            style: TextStyle(
                              fontSize: 14,
                              color: errorRedColor,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
