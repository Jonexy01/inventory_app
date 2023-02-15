import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DropDownWithBottomSheet extends HookConsumerWidget {
  final String? hintText;
  //final String currentValue;
  final List items;
  final ValueNotifier myvalue;
  //final bool isLoading;
  //final Function? onPop;
  //final bool isBank;
  const DropDownWithBottomSheet({
    Key? key,
    this.hintText,
    this.items = const [],
    required this.myvalue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
