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
import 'package:inventory_app/widgets/my_circular_text_button.dart';
import 'package:inventory_app/widgets/my_rounded_input_field.dart';
import 'package:inventory_app/widgets/my_rounded_password_field.dart';

import '../../../Widgets/my_have_an_account_check.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // bool waiting = false;
  bool isTextObscure = false;

  //text field state
  // String email = '';
  // String password = '';
  // String error = '';

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    final state = ref.watch(authViewModelProvider);
    final model = ref.read(authViewModelProvider.notifier);

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
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.amber,
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
                  }),
                  hintText: 'Enter email',
                  icon: Icons.person,
                ),
                RoundPasswordField(
                  controller: _passwordController,
                  obscureText: !isTextObscure,
                  onChanged: ((value) {
                    setState(
                      () {
                        _formKey.currentState!.validate();
                      },
                    );
                  }),
                  validator: ((value) =>
                      PasswordValidator.validatePassword(value!)),
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
                ),
                RoundedTextButton(
                  isLoading: state.loadStatus == Loader.loading,
                  text: 'Login',
                  press: () async {
                    // error = '';
                    if (_formKey.currentState!.validate()) {
                      // setState(() {
                      //   waiting = true;
                      // });
                      var cResult = await Connectivity().checkConnectivity();
                      if (cResult != ConnectivityResult.none) {
                        final myResult = await model.signinWithEmailAndPassword(
                          _emailController.text.trim(),
                          _passwordController.text,
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
                const SizedBox(height: 10),
                MyHaveAnAccountCheck(
                  press: () {
                    context.router.replace(const SignupPageRoute());
                    //Navigator.pushReplacementNamed(context, AppRoute.signup);
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    context.router.push(const ForgotPasswordPageRoute());
                  },
                  child: const Text('Forgot Password?'),
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
