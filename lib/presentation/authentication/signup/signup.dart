import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/core/utils/enums.dart';
//import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/validator.dart';
import 'package:inventory_app/presentation/waiting.dart';
//import 'package:inventory_app/core/services/auth.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';

import '../../../MyClasses/routes.dart';
import '../../../widgets/my_circular_text_button.dart';
import '../../../widgets/my_have_an_account_check.dart';
import '../../../widgets/my_rounded_input_field.dart';
import '../../../widgets/my_rounded_password_field.dart';
import '../../../widgets/or_divider.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool waiting = false;
  bool isTextObscure = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //text field state
  //String email = '';
  //String password = '';
  //String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final signupModel = ref.read(signupViewModelProvider.notifier);
    final signupState = ref.watch(signupViewModelProvider);

    return waiting
        ? const WaitingPage()
        : Scaffold(
            body: Container(
              width: double.infinity,
              height: size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.3,
                    ),
                    MyRoundedInputField(
                      controller: _emailController,
                      validator: (value) =>
                          EmailValidator.validateEmail(value!),
                      onChanged: ((value) {
                        //email = value;
                      }),
                      hintText: 'Enter email',
                      icon: Icons.person,
                    ),
                    MyRoundPasswordField(
                      controller: _passwordController,
                      obscureText: !isTextObscure,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isTextObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isTextObscure = !isTextObscure;
                          });
                        },
                      ),
                      validator: ((value) =>
                          PasswordValidator.validatePassword(value!)),
                      onChanged: (v) {
                        setState(
                          () {
                            _formKey.currentState!.validate();
                          },
                        );
                      },
                    ),
                    MyRoundPasswordField(
                      controller: _confirmPasswordController,
                      obscureText: !isTextObscure,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isTextObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isTextObscure = !isTextObscure;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Password do not match';
                        }
                        return null;
                      },
                      onChanged: (v) {
                        setState(() {
                          _formKey.currentState!.validate();
                        });
                      },
                    ),
                    MyCircularTextButton(
                      isLoading: signupState.loadStatus == Loader.loading,
                        text: 'Sign up',
                        press: () async {
                          //error = '';
                          if (_formKey.currentState!.validate()) {
                            var cResult =
                                await (Connectivity().checkConnectivity());
                            if (cResult != ConnectivityResult.none) {
                              final myResult =
                                  await signupModel.signupWithEmailPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              );
                              if (myResult.successMessage.isNotEmpty) {
                                AlertFlushbar.showNotification(
                                  message: myResult.successMessage,
                                  context: context,
                                );
                                context.router
                                    .replaceAll([const VerifyEmailPageRoute()]);
                              } else {
                                handleError(
                                    e: myResult.error ?? myResult.errorMessage,
                                    context: context);
                              }
                            } else {
                              showConnectionError(context: context);
                            }
                            // setState(() {
                            //   waiting = true;
                            // });
                            // dynamic result = await Future.any([
                            //   _auth.mySignUpWithEmailPassword(email, password),
                            //   Future.delayed(const Duration(seconds: 20), () {
                            //     setState(() {
                            //       error =
                            //           "It is taking too long. Contact admin if network is okay";
                            //       waiting = false;
                            //     });
                            //   })
                            // ]);
                            // //;
                            // if (result == null) {
                            //   setState(() {
                            //     error = 'Something went wrong';
                            //     waiting = false;
                            //   });
                            // } else {
                            //   Navigator.pushReplacementNamed(
                            //       context, AppRoute.statusSelect);
                            // }
                          }
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    // Text(
                    //   error,
                    //   style: const TextStyle(
                    //     color: Colors.red,
                    //     fontSize: 14,
                    //   ),
                    // ),
                    MyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.pushReplacementNamed(context, AppRoute.login);
                      },
                    ),
                    const OrDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.amber,
                            ),
                            shape: BoxShape.circle,
                          ),
                          // child: SvgPicture.asset(
                          //   'assets/icons/Facebook-f_Logo-Blue-Logo.wine.svg',
                          //   height: 20,
                          //   width: 20,
                          // ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
