import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/providers/app_providers.dart';
// import 'package:inventory_app/core/services/local_database/hive_keys.dart';
// import 'package:inventory_app/core/services/local_database/local_database.dart';
//import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    if (ref.read(firebaseAuthProvider).currentUser != null) {
      ref.read(authViewModelProvider.notifier).fetchUserRecord().then((value) {
        if (value.successMessage.isNotEmpty) {
          Future.delayed(const Duration(seconds: 5), () {
          context.router.replace(const WrapperRoute());
        });
        } else {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            handleError(e: value.error ?? value.errorMessage, context: context);
          });
          Future.delayed(const Duration(seconds: 5), () {
            context.router.replace(const LandingPageRoute());
          });
        }
        
      });
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        context.router.replace(const WrapperRoute());
      });
    }
  }

  // Future<void> checkPreference(BuildContext context) async {
  //   //final preferences = HiveStorage.get(HiveKeys.hasLoggedIn) ?? false;
  //   final state = ref.watch(loginViewModelProvider);

  //   if (state.user != null) {
  //     await Future.delayed(const Duration(microseconds: 0), () {
  //       context.router.replace(const HomePageRoute());
  //     });
  //   } else {
  //     await Future.delayed(const Duration(seconds: 5), () {
  //       context.router.replace(const LandingPageRoute());
  //     });
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[400],
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SpinKitFoldingCube(
            color: Colors.white,
            size: 100.0,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "The Inventory App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  }
}
