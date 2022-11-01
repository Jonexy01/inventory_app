import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/presentation/home/homepage/home_page.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';

class SecondaryWaitPage extends ConsumerStatefulWidget {
  const SecondaryWaitPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SecondaryWaitPage> createState() => _SecondaryWaitPageState();
}

class _SecondaryWaitPageState extends ConsumerState<SecondaryWaitPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(authViewModelProvider.notifier).fetchUserRecord();
    });
    timer = Timer.periodic(const Duration(seconds: 6), (_) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        ref
            .read(authViewModelProvider.notifier)
            .fetchUserRecord()
            .then((value) {
          if (ref.read(authViewModelProvider).userRecord != null &&
              ref.read(authViewModelProvider).userRecord!.approved == true) {
            timer!.cancel();
          }
        });
      });
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(authViewModelProvider.notifier);
    final state = ref.watch(authViewModelProvider);

    if (state.userRecord != null &&
        state.userRecord!.approved != null &&
        state.userRecord!.approved!) return const HomePage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Primary user'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await model.signout();
              context.router.replaceAll([const LandingPageRoute()]);
            },
            icon: const Icon(Icons.logout),
            tooltip: 'sign out',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: const [
              Text('Please follow up on the primary user for approval'),
              SizedBox(height: 10),
              Text('You will be automatically logged in once the user approves')
            ],
          ),
        ),
      ),
    );
  }
}
