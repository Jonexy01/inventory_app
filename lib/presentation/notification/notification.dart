import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';
import 'package:inventory_app/widgets/app_options_dialogue.dart';
import 'package:inventory_app/widgets/app_spinkit.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(notificationViewModelProvider.notifier).fetchAllNotifications();
    });
  }
  //List notifications = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationViewModelProvider);
    final model = ref.read(notificationViewModelProvider.notifier);
    final userState = ref.watch(authViewModelProvider);
    final userModel = ref.read(authViewModelProvider.notifier);
    //final notifications = state.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SizedBox(
        width: width(context) * 0.9,
        child: state.loadStatus == Loader.loading
            ? const Center(child: AppLoading(size: 80))
            : Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Most Recent',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, item) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (state.notifications![item].notificationType ==
                                'SecondaryApproval') {
                              model
                                  .loadNotification(state.notifications![item]);
                              // context.router
                              //     .push(const SecondaryUserApprovalRoute());
                              await showDialog(
                                context: context,
                                builder: (context) => AppOptionsDialogue(
                                  provider: notificationViewModelProvider,
                                  title: 'Approve',
                                  subtitle:
                                      'Please approve/decline secondary user ${state.notification!.userNotifying}',
                                  onPressedproceed: () async {
                                    final response1 =
                                        await model.fetchSecondaryUser(
                                            secondaryUserId:
                                                userState.user!.uid);
                                    if (response1.successMessage.isNotEmpty) {
                                      final response2 =
                                          await model.addSecondaryUser(
                                              userRecord: userState
                                                  .secondaryUserRecord!,
                                              primaryUid: userState.user!.uid);
                                      if (response2.successMessage.isNotEmpty) {
                                        await model.removeNotification(
                                            notificationId:
                                                state.notification!.id!);
                                        model.fetchAllNotifications();
                                        WidgetsBinding.instance!
                                            .addPostFrameCallback((timeStamp) {
                                          AlertFlushbar.showNotification(
                                              context: context,
                                              message:
                                                  response2.successMessage);
                                        });
                                        context.router.pop();
                                        setState(() {});
                                      } else {
                                        handleError(
                                            e: response2.error ??
                                                response1.errorMessage,
                                            context: context);
                                      }
                                    } else {
                                      handleError(
                                          e: response1.error ??
                                              response1.errorMessage,
                                          context: context);
                                    }
                                  },
                                  proceedText: 'Approve',
                                  onPressedDecline: () async {
                                    final response =
                                        await model.removeNotification(
                                            notificationId:
                                                state.notification!.id!);
                                    if (response.successMessage.isNotEmpty) {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((timeStamp) {
                                        AlertFlushbar.showNotification(
                                            context: context,
                                            message: 'User declined');
                                      });
                                      context.router.pop();
                                      setState(() {});
                                    } else {
                                      handleError(
                                          e: response.error ??
                                              response.errorMessage,
                                          context: context);
                                    }
                                  },
                                ),
                              );
                            }
                          },
                          child: ListTile(
                            title: Text(state.notifications![item].title!),
                            subtitle: Text(state.notifications![item].body!),
                          ),
                        )),
                    separatorBuilder: (context, item) =>
                        const SizedBox(height: 5),
                    itemCount: state.notifications != null
                        ? state.notifications!.length
                        : 0,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
      ),
    );
  }
}
