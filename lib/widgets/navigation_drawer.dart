import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/widgets/menu_tile.dart';

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

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(context,
                businessName: state.userRecord!.businessName!,
                name: state.userRecord!.name!),
            buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(context,
      {required String businessName, required String name}) {
    return Container(
      width: double.infinity,
      color: AppColors.purple600,
      padding: EdgeInsets.only(top: 20 + MediaQuery.of(context).padding.top, bottom: 20,),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            businessName,
            style: const TextStyle(fontSize: 20, color: AppColors.white,),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 16, color: AppColors.white,),
          ),
        ],
      ),
    );
  }

  Widget buildBody(context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, item) => MenuTile(
        menuItem: menuList[item],
      ),
      separatorBuilder: (context, item) => Column(children: const [
        Divider(color: AppColors.black),
        SizedBox(height: 16),
      ]),
      itemCount: menuList.length,
    );
  }
}
