import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
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
                          onTap: () {
                            if (state.notifications![item].notificationType ==
                                'SecondaryApproval') {
                              ref
                                  .read(secondaryApprovalViewModelProvider
                                      .notifier)
                                  .loadNotification(state.notifications![item]);
                              context.router
                                  .push(const SecondaryUserApprovalRoute());
                            }
                          },
                          child: ListTile(
                            title: Text(state.notifications![item].title!),
                            subtitle: Text(state.notifications![item].body!),
                          ),
                        )),
                    separatorBuilder: (context, item) =>
                        const SizedBox(height: 5),
                    itemCount: state.notifications!.length,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
      ),
    );
  }
}
