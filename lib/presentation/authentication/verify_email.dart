import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/presentation/authentication/role_select.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';

class VerifyEmailPage extends ConsumerStatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends ConsumerState<VerifyEmailPage> {
  @override
  void initState() {
    super.initState();
    isEmailVerified = ref.read(firebaseAuthProvider).currentUser!.emailVerified;
    //final userModel = ref.read(authViewModelProvider.notifier);
    //WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    if (!isEmailVerified) {
      waitB4Resend();
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
    //});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future waitB4Resend() async {
    if (mounted) {
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 60));
      if (mounted) {
        setState(() => canResendEmail = true);
      }
    }
  }

  Future checkEmailVerified() async {
    await ref.read(firebaseAuthProvider).currentUser!.reload();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          isEmailVerified =
              ref.read(firebaseAuthProvider).currentUser!.emailVerified;
        });
      }
    });
    if (isEmailVerified) timer!.cancel();
  }

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final userModel = ref.read(authViewModelProvider.notifier);
    final state = ref.watch(authViewModelProvider);

    if (isEmailVerified) {
      return const RoleSelectPage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
        ),
        body: Container(
          height: height(context),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                  'A verification email has been sent to your email address. You will be signed in automatically after verifying email'),
              const SizedBox(height: 10),
              RoundedTextButton(
                isLoading: state.loadStatus == Loader.loading,
                color: canResendEmail ? AppColors.purple : AppColors.purple200,
                text: 'Resend email',
                press: () {
                  canResendEmail
                      ? userModel.sendVerificationEmail().then((value) {
                          if (value.successMessage.isNotEmpty) {
                            SchedulerBinding.instance!
                                .addPostFrameCallback((timeStamp) {
                              AlertFlushbar.showNotification(
                                message: value.successMessage,
                                context: context,
                              );
                            });
                          } else {
                            handleError(
                                e: value.error ?? value.errorMessage,
                                context: context);
                          }
                        })
                      : () {};
                  canResendEmail ? waitB4Resend() : () {};
                },
              ),
              const SizedBox(height: 10),
              RoundedTextButton(
                isLoading: state.loadStatus == Loader.loading,
                text: 'Cancel',
                press: () async {
                  timer?.cancel();
                  await userModel.signout();
                  context.router.replace(const WrapperRoute());
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
