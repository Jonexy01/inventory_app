import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/core/utils/validator.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // bool waiting = false;
  bool isTextObscure = false;
  bool iscTextObscure = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //text field state
  //String email = '';
  //String password = '';
  //String error = '';

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    final model = ref.read(authViewModelProvider.notifier);
    final state = ref.watch(authViewModelProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height(context),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Text(
                  'Sign up',
                  style: TextStyle(
                    color: AppColors.amber,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // SizedBox(
                //   height: size.height * 0.3,
                // ),
                RoundedInputField(
                  controller: _emailController,
                  validator: (value) => EmailValidator.validateEmail(value!),
                  onChanged: ((value) {
                    setState(
                      () {
                        _formKey.currentState!.validate();
                      },
                    );
                    //email = value;
                  }),
                  hintText: 'Enter email',
                  icon: Icons.person,
                ),
                RoundPasswordField(
                  controller: _passwordController,
                  obscureText: !isTextObscure,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isTextObscure ? Icons.visibility : Icons.visibility_off,
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
                RoundPasswordField(
                  controller: _confirmPasswordController,
                  obscureText: !iscTextObscure,
                  suffixIcon: IconButton(
                    icon: Icon(
                      iscTextObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        iscTextObscure = !iscTextObscure;
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
                RoundedTextButton(
                  isLoading: state.loadStatus == Loader.loading,
                  text: 'Sign up',
                  press: () async {
                    //error = '';
                    if (_formKey.currentState!.validate()) {
                      var cResult = await (Connectivity().checkConnectivity());
                      if (cResult != ConnectivityResult.none) {
                        final myResult = await model.signupWithEmailPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        );
                        if (myResult.successMessage.isNotEmpty) {
                          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                            AlertFlushbar.showNotification(
                            message: myResult.successMessage,
                            context: context,
                          );
                          });
                          
                          context.router
                              .replaceAll([const VerifyEmailPageRoute()]);
                        } else {
                          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                            handleError(
                              e: myResult.error ?? myResult.errorMessage,
                              context: context);
                          });
                        }
                      } else {
                        showConnectionError(context: context);
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    context.router.replace(const LoginPageRoute());
                    //Navigator.pushReplacementNamed(context, AppRoute.login);
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
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
