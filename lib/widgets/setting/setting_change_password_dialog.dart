import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/setting/setting_change_password.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingChangePasswordDialog extends StatefulWidget {
  final String title;
  final String content;
  final bool? backButton;
  final VoidCallback? backButtonFunction;
  final bool? resetPasswordMode;
  final VoidCallback? onBackFunction;
  final VoidCallback? redButtonFunction;
  final VoidCallback grayButtonOnClick;
  final String secondButtonTitle;
  final VoidCallback secondButtonOnClick;

  const SettingChangePasswordDialog(
      {super.key,
      required this.title,
      required this.content,
      this.backButton,
      this.backButtonFunction,
      this.resetPasswordMode,
      this.onBackFunction,
      this.redButtonFunction,
      required this.grayButtonOnClick,
      required this.secondButtonTitle,
      required this.secondButtonOnClick});

  @override
  State<SettingChangePasswordDialog> createState() =>
      _SettingChangePasswordDialogState();
}

class _SettingChangePasswordDialogState
    extends State<SettingChangePasswordDialog> {
  final SettingChangePasswordController _changePasswordController =
      SettingChangePasswordController();
  bool newPasswordVisibility = false;
  bool confirmNewPasswordVisibility = false;
  String errorMessage = "";
  final _formKey = GlobalKey<FormState>();
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future checkPassword() async {
    setState(() {
      errorMessage = "";
    });
    try {
      if (currentUser != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: currentUser!.email!,
          password: _changePasswordController.currentPassword,
        );
        await currentUser?.reauthenticateWithCredential(credential);
        widget.secondButtonOnClick();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        setState(() {
          errorMessage = 'Incorrect password';
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future setNewPassword() async {
    setState(() {
      errorMessage = "";
    });
    if (_changePasswordController.newPassword ==
        _changePasswordController.confirmNewPassword) {
      try {
        await currentUser?.updatePassword(
            _changePasswordController.newPasswordController.text);
        widget.secondButtonOnClick();
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      setState(() {
        errorMessage = 'New password and confirm new password must be matched';
      });
    }
  }

  Future checkEmail() async {
    setState(() {
      errorMessage = "";
    });
    if (currentUser!.email! != _changePasswordController.email) {
      setState(() {
        errorMessage = "Your email is incorrect";
      });
    } else {
      widget.secondButtonOnClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: backgroundColor,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: widget.redButtonFunction != null ||
                            widget.resetPasswordMode == true
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      if (widget.backButton == true) ...[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: blackColor,
                            ),
                            onPressed: widget.backButtonFunction),
                      ],
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.content,
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.resetPasswordMode == true) ...[
                    TextFormField(
                        controller:
                            _changePasswordController.newPasswordController,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300),
                        cursorColor: blackColor,
                        obscureText: !newPasswordVisibility,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() => errorMessage = "");
                            return 'Please enter password';
                          } else if (value.length < 8) {
                            setState(() => errorMessage = "");
                            return "Password must be at least 8 characters long";
                          } else if (!RegExp(r'[@#%^&*_-]').hasMatch(value)) {
                            setState(() => errorMessage = "");
                            return "Password must contain at least one special character @#%^&*_-";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorMaxLines: 2,
                            hintText: 'New password',
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: darkGreyColor, width: 0.5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: darkGreyColor, width: 0.5)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: blackColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  newPasswordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: darkBeigeColor),
                              onPressed: () {
                                setState(() {
                                  newPasswordVisibility =
                                      !newPasswordVisibility;
                                });
                              },
                            ))),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _changePasswordController
                            .confirmNewPasswordController,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300),
                        cursorColor: blackColor,
                        obscureText: !confirmNewPasswordVisibility,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() => errorMessage = "");
                            return 'Please enter password';
                          } else if (value.length < 8) {
                            setState(() => errorMessage = "");
                            return "Password must be at least 8 characters long";
                          } else if (!RegExp(r'[@#%^&*_-]').hasMatch(value)) {
                            setState(() => errorMessage = "");
                            return "Password must contain at least one special character @#%^&*_-";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorMaxLines: 2,
                            hintText: 'Confirm new password',
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: darkGreyColor, width: 0.5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: darkGreyColor, width: 0.5)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: blackColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                confirmNewPasswordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: darkBeigeColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  confirmNewPasswordVisibility =
                                      !confirmNewPasswordVisibility;
                                });
                              },
                            ))),
                  ] else ...[
                    TextFormField(
                        controller: widget.backButton == true
                            ? _changePasswordController.emailController
                            : _changePasswordController
                                .currentPasswordController,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300),
                        cursorColor: blackColor,
                        obscureText: !(widget.backButton ?? false),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty && widget.backButton != true) {
                            setState(() => errorMessage = "");
                            return 'Please enter password';
                          } else if ((value.isEmpty ||
                                  !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) &&
                              widget.backButton == true) {
                            setState(() {
                              errorMessage = "";
                            });
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: widget.backButton == true
                                ? 'Registered Email'
                                : 'Current password',
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: darkGreyColor, width: 0.5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: darkGreyColor, width: 0.5)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: blackColor))),
                    const SizedBox(
                      height: 5,
                    ),
                    if (widget.redButtonFunction != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: widget.redButtonFunction,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: redColor,
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              )),
                        ],
                      )
                    ],
                  ],
                  Visibility(
                    visible: errorMessage.isNotEmpty,
                    child: const SizedBox(
                      height: 20,
                    ),
                  ),
                  Visibility(
                    visible: errorMessage.isNotEmpty,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFEFF2),
                                border: Border.all(
                                    color: const Color(0xFFB7415E), width: 2),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BakingUpLongActionButton(
                        title: 'Cancel',
                        color: greyColor,
                        width: 120,
                        onClick: widget.grayButtonOnClick,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      BakingUpLongActionButton(
                        title: widget.secondButtonTitle,
                        color: lightGreenColor,
                        width: 130,
                        onClick: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.resetPasswordMode != true &&
                                widget.backButton != true) {
                              checkPassword();
                            } else if (widget.resetPasswordMode == true) {
                              setNewPassword();
                            } else if (widget.backButton == true) {
                              checkEmail();
                            }
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
