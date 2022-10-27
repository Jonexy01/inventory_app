import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/core/utils/validator.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';
import 'package:inventory_app/widgets/my_rounded_input_field.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(authViewModelProvider.notifier);
    final state = ref.watch(authViewModelProvider);

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Receive an email to reset your password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              RoundedInputField(
                icon: Icons.email,
                controller: _emailController,
                validator: (value) => EmailValidator.validateEmail(value!),
                hintText: 'Enter email',
              ),
              const SizedBox(height: 10),
              RoundedTextButton(
                isLoading: state.loadStatus == Loader.loading,
                text: 'Reset Password',
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    final response =
                        await model.resetPassword(_emailController.text.trim());
                    if (response.successMessage.isNotEmpty) {
                      SchedulerBinding.instance!
                          .addPostFrameCallback((timeStamp) {
                        AlertFlushbar.showNotification(
                          message: response.successMessage,
                          context: context,
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          context.router.push(const LoginPageRoute());
                        });
                      });
                    } else {
                      handleError(
                          e: response.error ?? response.errorMessage,
                          context: context);
                    }
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
