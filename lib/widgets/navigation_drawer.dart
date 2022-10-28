import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/drawer_menu_item_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/drawer_menu_tile.dart';

class NavigationDrawer extends ConsumerStatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends ConsumerState<NavigationDrawer> {
  //final menuList = const [];
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    List<DrawerMenuItem> menuList = [
      DrawerMenuItem(
        leading: const Icon(Icons.home_outlined),
        titleText: 'Home',
        route: const HomePageRoute(),
      ),
      DrawerMenuItem(
        leading: const Icon(Icons.notifications_outlined),
        titleText: 'Notifications',
        route: const NotificationPageRoute(),
      ),
      if (state.userRecord!.role == 'primary')
      DrawerMenuItem(
        leading: const Icon(Icons.person),
        titleText: 'Secondary Users',
        route: const SecondaryUserDisplayRoute(),
      ),
      DrawerMenuItem(
        leading: const Icon(Icons.logout_outlined),
        titleText: 'Logout',
        // onTap: () {},
        route: const LandingPageRoute(),
      ),
    ];

    return SizedBox(
      width: width(context) * 0.8,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(context,
                  businessName: state.userRecord!.businessName!,
                  name: state.userRecord!.name!),
              buildBody(context: context, menuList: menuList,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(context,
      {required String businessName, required String name}) {
    return Container(
      width: double.infinity,
      color: AppColors.purple600,
      padding: EdgeInsets.only(
        top: 20 + MediaQuery.of(context).padding.top,
        bottom: 20,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            businessName,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody({required BuildContext context, required List<DrawerMenuItem> menuList}) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, item) => DrawerMenuTile(
        menuItem: menuList[item],
      ),
      separatorBuilder: (context, item) => Column(children: const [
        Divider(
          color: AppColors.amber,
        ),
        SizedBox(height: 2),
      ]),
      itemCount: menuList.length,
    );
  }
}
