import 'dart:async';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/screens/auth/login_screen.dart';
import 'package:bakingup_frontend/screens/home_screen.dart';
import 'package:bakingup_frontend/widgets/baking_up_theme_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  Timer? countdownTimer;
  int countdown = 10; 
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      isEmailVerified = currentUser.emailVerified;
      if (!isEmailVerified) {
        sendVerificationEmail();
        startCountdown();

        timer = Timer.periodic(
            const Duration(seconds: 3), (_) => checkEmailVerified());
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    timer?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await currentUser.reload();

      setState(() {
        isEmailVerified = currentUser.emailVerified;
      });

      if (isEmailVerified) timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      if (_isDisposed) return;

      setState(() => canResendEmail = false);
      startCountdown();
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
  Widget build(BuildContext context) => isEmailVerified
      ? const LoginScreen()
      : Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: darkBeigeColor,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  const AssetImage("assets/icons/email.png"),
                              backgroundColor:
                                  lightYellowColor.withOpacity(0.4),
                              radius: 65,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Check Your Email",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "To protect your privacy, please verify your email address.",
                              style: TextStyle(color: darkGreyColor),
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
                                      context,
                                      loginRoute,
                                      (Route<dynamic> route) => false);
                                },
                                paddingHorizontal:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                      color: canResendEmail
                                          ? yellowColor
                                          : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: canResendEmail
                                        ? (TapGestureRecognizer()
                                          ..onTap = sendVerificationEmail)
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
}
