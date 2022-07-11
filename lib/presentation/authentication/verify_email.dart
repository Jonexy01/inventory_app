import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/presentation/home/homepage/home_page.dart';
import 'package:inventory_app/providers/app_providers.dart';
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
    final userModel = ref.read(authViewModelProvider.notifier);
    if (!isEmailVerified) {
      try {
        userModel.sendVerificationEmail();
        waitB4Resend();
      } catch (e) {
        handleError(e: e, context: context);
      }
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future waitB4Resend() async {
    setState(() => canResendEmail = false);
    await Future.delayed(const Duration(seconds: 5));
    setState(() => canResendEmail = true);
  }

  Future checkEmailVerified() async {
    await ref.read(firebaseAuthProvider).currentUser!.reload();
    setState(() {
      isEmailVerified =
          ref.read(firebaseAuthProvider).currentUser!.emailVerified;
    });
    if (isEmailVerified) timer!.cancel();
  }

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final userModel = ref.read(authViewModelProvider.notifier);

    if (isEmailVerified) {
      return const HomePage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
                'A verification email has been sent to your email address'),
            const SizedBox(height: 10),
            RoundedTextButton(
              text: 'Resend email',
              press: () {
                canResendEmail ? userModel.sendVerificationEmail() : () {};
              },
            ),
            const SizedBox(height: 10),
            RoundedTextButton(
              text: 'Cancel',
              press: () {
                //Implement sign out
              },),
          ],
        ),
      );
    }
  }
}
