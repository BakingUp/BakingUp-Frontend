import 'package:bakingup_frontend/models/auth/login_controller.dart';
import 'package:bakingup_frontend/screens/home_screen.dart';
import 'package:bakingup_frontend/screens/auth/register_screen.dart';
import 'package:bakingup_frontend/screens/auth/forgot_password_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_theme_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bakingup_frontend/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  String errorMessage = "";
  final LoginTextEditController _loginController = LoginTextEditController();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseAuth user = FirebaseAuth.instance;

  void navigate() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  Future<String> getDeviceToken() async {
    try {
      return (await messaging.getToken()) ?? '';
    } catch (e) {
      debugPrint("Error retrieving device token: $e");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [darkBeigeColor, lightYellowColor],
      )),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  const AssetImage("assets/icons/logo.png"),
                              radius: 120,
                              backgroundColor: darkBrownColor,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  cursorColor: darkBrownColor,
                                  controller: _loginController.emailController,
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
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 15),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: darkBrownColor, width: 2),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: darkBeigeColor,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Type your email"),
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  cursorColor: darkBrownColor,
                                  controller:
                                      _loginController.passwordController,
                                  obscureText: passwordVisible,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      setState(() => errorMessage = "");
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 15),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: darkBrownColor, width: 2),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.key,
                                        color: darkBeigeColor,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: darkBeigeColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            passwordVisible = !passwordVisible;
                                          });
                                        },
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Type your password"),
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordScreen()));
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: redColor,
                                    ),
                                  ),
                                )
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
                                        style:
                                            TextStyle(color: Colors.grey[800]),
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
                                CustomButton(
                                  color: "primary",
                                  text: "Login",
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  content: SizedBox(
                                                    height: 120,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CircularProgressIndicator(
                                                                  color:
                                                                      darkBeigeColor,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const Text(
                                                                    "Loading..."),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: _loginController.email,
                                                password:
                                                    _loginController.password);

                                        var token = await getDeviceToken();
                                        final data = {
                                          "user_id": user.currentUser?.uid,
                                          "device_token": token,
                                        };

                                        final response =
                                            await NetworkService.instance
                                                .post(
                                          "/api/auth/addDeviceToken",
                                          data: data,
                                        )
                                                .catchError((error) {
                                          debugPrint(
                                              "Post request failed: $error");
                                        });

                                        if (response == null) {
                                          debugPrint('API response is null');
                                        } else if (response is! Map) {
                                          debugPrint(
                                              'Unexpected response type: ${response.runtimeType}');
                                        } else {
                                          debugPrint('API response: $response');
                                        }

                                        debugPrint("Successfully login");
                                        navigate();
                                      } on FirebaseAuthException catch (e) {
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                        if (e.code == 'user-not-found') {
                                          setState(() {
                                            errorMessage = "User not found";
                                          });
                                          debugPrint(
                                              'No user found for that email');
                                        } else if (e.code == 'wrong-password') {
                                          setState(() {
                                            errorMessage = "Wrong password";
                                          });
                                          debugPrint(
                                              'wrong password provided for that user');
                                        }
                                      }
                                    }
                                  },
                                  paddingHorizontal: const EdgeInsets.symmetric(
                                      horizontal: 60),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Dont't have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()));
                                  },
                                  child: Text(
                                    "Create",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: redColor),
                                  ),
                                )
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
