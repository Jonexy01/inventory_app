import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/presentation/authentication/verify_email.dart';
import 'package:inventory_app/presentation/splash/landing_page.dart';
import 'package:inventory_app/providers/app_providers.dart';

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  ConsumerState<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {
  @override
  Widget build(BuildContext context) {

    //final state = ref.watch(authViewModelProvider);

    if (ref.read(firebaseAuthProvider).currentUser == null) {
      //state.user == null) {
      return const LandingPage();
    } else {
      return const VerifyEmailPage();
    }

    
    // final currentUser = Provider.of<MyUser?>(context);

    // //return either home or authenticate widget
    // if (currentUser == null) {
    //   return LandingPage();
    // } else {
    //   return HomePage();
    // }
    
  }
}