import 'dart:async';

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/widgets/baking_up_theme_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SettingChangePasswordEmailDialog extends StatefulWidget {
  const SettingChangePasswordEmailDialog({super.key});

  @override
  State<SettingChangePasswordEmailDialog> createState() =>
      _SettingVerifyEmailDialogState();
}

class _SettingVerifyEmailDialogState
    extends State<SettingChangePasswordEmailDialog> {
  bool canResendEmail = false;
  Timer? timer;
  Timer? countdownTimer;
  int countdown = 10;
  bool _isDisposed = false;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String errorMessage = "";
  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      sendResetPasswordEmail();
      startCountdown();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    timer?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  Future sendResetPasswordEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: currentUser?.email ?? "");
      if (_isDisposed) return;

      setState(() => canResendEmail = false);
      startCountdown();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        setState(() => errorMessage = "user not found");
      }
    } catch (e) {
      if (_isDisposed) return;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void startCountdown() {
    setState(() => countdown = 10);

    countdownTimer?.cancel();

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() => countdown--);
      } else {
        setState(() {
          canResendEmail = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: backgroundColor,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: const AssetImage("assets/icons/email.png"),
                backgroundColor: lightYellowColor.withOpacity(0.4),
                radius: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Check Your Email",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                "To protect your privacy, please verify your email address.",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 150,
                child: CustomButton(
                  color: "secondary",
                  text: "Back to Login",
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, loginRoute, (Route<dynamic> route) => false);
                  },
                  paddingHorizontal: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Didn't get e-mail? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: canResendEmail
                          ? "Send it again"
                          : "Send it again ($countdown)",
                      style: TextStyle(
                        color: canResendEmail ? yellowColor : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: canResendEmail
                          ? (TapGestureRecognizer()
                            ..onTap = sendResetPasswordEmail)
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
