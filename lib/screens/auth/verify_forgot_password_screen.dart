import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/widgets/baking_up_theme_button.dart';
import 'package:flutter/material.dart';

class VerifyForgotPasswordScreen extends StatefulWidget {
  const VerifyForgotPasswordScreen({super.key});

  @override
  State<VerifyForgotPasswordScreen> createState() =>
      _VerifyForgotPasswordScreenState();
}

class _VerifyForgotPasswordScreenState
    extends State<VerifyForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                          backgroundColor: lightYellowColor.withOpacity(0.4),
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
                          "Please check inbox and click in the received link to reset a password",
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
                              Navigator.pushNamedAndRemoveUntil(context,
                                  loginRoute, (Route<dynamic> route) => false);
                            },
                            paddingHorizontal:
                                const EdgeInsets.symmetric(horizontal: 20),
                          ),
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
}
