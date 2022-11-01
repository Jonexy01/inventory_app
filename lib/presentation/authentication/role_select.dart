import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/presentation/authentication/secondary_wait.dart';
import 'package:inventory_app/presentation/home/homepage/home_page.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';

class RoleSelectPage extends ConsumerStatefulWidget {
  const RoleSelectPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RoleSelectPage> createState() => _RoleSelectPageState();
}

class _RoleSelectPageState extends ConsumerState<RoleSelectPage> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);
    final model = ref.read(authViewModelProvider.notifier);

    if (state.userRecord!.role == 'secondary') return const SecondaryWaitPage();

    if (state.userRecord!.role != null && state.userRecord!.role!.isNotEmpty) {
      return const HomePage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Select Role'),
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
        body: SingleChildScrollView(
          child: Container(
            height: height(context),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Text('Please choose how you want to use the app'),
                const Spacer(),
                RoundedTextButton(
                    color: AppColors.purple600,
                    text: 'Create as admin/primary user',
                    press: () {
                      this.context.router.replace(const StopoverPageRoute());
                      //Navigator.pushReplacementNamed(context, AppRoute.home);
                    }),
                const SizedBox(height: 10),
                RoundedTextButton(
                    color: AppColors.amber,
                    text: 'Join an existing business',
                    press: () {
                      this.context.router.replace(const StopoverAddUserPageRoute());
                    }),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    }
  }
}
