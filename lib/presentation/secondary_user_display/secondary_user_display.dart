import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/providers/app_providers.dart';

class SecondaryUserDisplay extends ConsumerStatefulWidget {
  const SecondaryUserDisplay({Key? key}) : super(key: key);

  @override
  ConsumerState<SecondaryUserDisplay> createState() =>
      _SecondaryUserDisplayState();
}

class _SecondaryUserDisplayState extends ConsumerState<SecondaryUserDisplay> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(secondaryUsersViewModel.notifier).fetchSecondaryUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(secondaryUsersViewModel);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Secondary Users'),
      ),
      body: state.secondaryUsers == null || state.secondaryUsers!.isEmpty
          ? const Center(
              child: Text('No Secondary User to display'),
            )
          : SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.secondaryUsers![index].name!),
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 3),
                itemCount: state.secondaryUsers!.length,
              ),
            ),
    );
  }
}
