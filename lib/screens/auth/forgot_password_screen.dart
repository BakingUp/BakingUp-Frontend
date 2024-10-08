import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/screens/auth/verify_forgot_password_screen.dart';
import 'package:bakingup_frontend/widgets/baking_up_theme_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String errorMessage = "";

  Future sendResetPasswordEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        setState(() => errorMessage = "user not found");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: darkBeigeColor
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
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                  setState(() => errorMessage = "");
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: darkBeigeColor,
                                  ),
                                  hintText: "Type your email"),
                            )),
                          ],
                        ),
                        Visibility(
                          visible: errorMessage != "" ? true : false,
                          child: const SizedBox(
                            height: 20,
                          ),
                        ),
                        Visibility(
                          visible: errorMessage != "" ? true : false,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFEFF2),
                                      border: Border.all(
                                          color: const Color(0xFFB7415E),
                                          width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    errorMessage,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              color: "secondary",
                              text: "Back to Login",
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      loginRoute,
                                      (Route<dynamic> route) => false);
                              },
                              paddingHorizontal:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            CustomButton(
                              color: "primary",
                              text: "Confirm",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  sendResetPasswordEmail();
                                  debugPrint(errorMessage);
                                  errorMessage == ""
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VerifyForgotPasswordScreen()))
                                      : null;
                                  debugPrint(
                                      "sent email to reset password successfully");
                                }
                              },
                              paddingHorizontal:
                                  const EdgeInsets.symmetric(horizontal: 40),
                            )
                          ],
                        )
                      ],
                    ),
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
