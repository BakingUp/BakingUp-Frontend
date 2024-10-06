import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/models/auth/register_controller.dart';
import 'package:bakingup_frontend/screens/auth/verify_email_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/auth/confirm_password_text_form_field.dart';
import 'package:bakingup_frontend/widgets/auth/password_text_form_field.dart';
import 'package:bakingup_frontend/widgets/auth/register_text_form_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_theme_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  final _registerController = RegisterTextEditController();
  List<bool> password = [true, true];
  String errorMessage = "";

  void navigate() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const VerifyEmailScreen()));
  }

  void errorConfirmPassword() {
    setState(() => errorMessage = "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: darkBeigeColor,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formkey,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 35),
                      margin: const EdgeInsets.only(top: 30),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RegisterTextFormField(
                              controller: _registerController.emailController,
                              validate: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$')
                                        .hasMatch(value)) {
                                  setState(() => errorMessage = "");
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              hintText: "Email"),
                          const SizedBox(
                            height: 20,
                          ),
                          RegisterTextFormField(
                              controller:
                                  _registerController.firstnameController,
                              validate: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r'^\w+$').hasMatch(value)) {
                                  setState(() => errorMessage = "");
                                  return "Please enter first name";
                                }
                                return null;
                              },
                              hintText: "First Name"),
                          const SizedBox(
                            height: 20,
                          ),
                          RegisterTextFormField(
                              controller:
                                  _registerController.lastnameController,
                              validate: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r'^\w+$').hasMatch(value)) {
                                  setState(() => errorMessage = "");
                                  return "Please enter last name";
                                }
                                return null;
                              },
                              hintText: "Last Name"),
                          const SizedBox(
                            height: 40,
                          ),
                          PasswordTextFormField(
                              passwordVisible: password,
                              controller:
                                  _registerController.passwordController,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() => errorMessage = "");
                                  return 'Please enter password';
                                } else if (value.length < 8) {
                                  setState(() => errorMessage = "");
                                  return "Password must be at least 8 characters long";
                                } else if (!RegExp(r'[@#%^&*_-]')
                                    .hasMatch(value)) {
                                  setState(() => errorMessage = "");
                                  return "Password must contain at least one special character @#%^&*_-";
                                }
                                return null;
                              },
                              hintText: "Password"),
                          const SizedBox(
                            height: 20,
                          ),
                          ConfirmPasswordFormField(
                              error: errorConfirmPassword,
                              confirmPasswordController:
                                  _registerController.confirmPasswordController,
                              passwordController:
                                  _registerController.passwordController,
                              hintText: "Confirm password"),
                          const SizedBox(
                            height: 40,
                          ),
                          RegisterTextFormField(
                            controller:
                                _registerController.phoneNumberController,
                            validate: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !RegExp(r'^\+?[0-9\s\-\(\)]+$')
                                      .hasMatch(value)) {
                                setState(() => errorMessage = "");
                                return "Please enter valid phone number";
                              }
                              return null;
                            },
                            hintText: "Phone Number",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RegisterTextFormField(
                            controller: _registerController.storeNameController,
                            validate: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !RegExp(r'^\w+$').hasMatch(value)) {
                                //แก้ให้มัน โอกัย spacebar
                                setState(() => errorMessage = "");
                                return "Please enter store name";
                              }
                              return null;
                            },
                            hintText: "Store Name",
                          ),
                          const SizedBox(
                            height: 10,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
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
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    try {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          content: SizedBox(
                                            height: 120,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircularProgressIndicator(
                                                          color: yellowColor,
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Text(
                                                            "Loading..."),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                      UserCredential userCredential =
                                          await FirebaseAuth
                                              .instance
                                              .createUserWithEmailAndPassword(
                                                  email: _registerController
                                                      .email
                                                      .trim(),
                                                  password: _registerController
                                                      .password
                                                      .trim());

                                      final response =
                                          await NetworkService.instance.post(
                                              "/api/auth/register",
                                              data: {
                                            "user_id": userCredential.user?.uid,
                                            "first_name":
                                                _registerController.firstname,
                                            "last_name":
                                                _registerController.lastname,
                                            "tel":
                                                _registerController.phoneNumber,
                                            "store_name":
                                                _registerController.storeName,
                                          });
                                      if (response == null) {
                                        debugPrint('API response is null');
                                      } else {
                                        debugPrint('API response: $response');
                                      }

                                      // SuccessAuth d =
                                      //     SuccessAuth.fromJson(response.data);

                                      // UserProvider.setKey(key: d.data);

                                      debugPrint("register successful");
                                      navigate();
                                    } on FirebaseAuthException catch (e) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                      if (e.code == 'email-already-in-use') {
                                        setState(() => errorMessage =
                                            "email already in use");
                                        debugPrint(
                                            'The account already exists for that email.');
                                      }
                                    } catch (e) {
                                      FirebaseAuth.instance.currentUser
                                          ?.delete();
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                      debugPrint(e.toString());
                                    }
                                  }
                                },
                                paddingHorizontal:
                                    const EdgeInsets.symmetric(horizontal: 40),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
