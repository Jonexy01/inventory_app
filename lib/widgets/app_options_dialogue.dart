import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/widgets/app_spinkit.dart';

class AppOptionsDialogue extends ConsumerStatefulWidget {
  const AppOptionsDialogue({ Key? key, this.icon,
    this.title = 'Warning',
    this.subtitle = '',
    this.onPressedDecline,
    this.onPressedproceed,
    this.provider,
    this.declineText,
    this.proceedText, }) : super(key: key);

  final Widget? icon;
  final String title;
  final String subtitle;
  final Function()? onPressedDecline;
  final Function()? onPressedproceed;
  final StateNotifierProvider? provider;
  final String? declineText;
  final String? proceedText;

  @override
  ConsumerState<AppOptionsDialogue> createState() => _AppOptionsDialogueState();
}

class _AppOptionsDialogueState extends ConsumerState<AppOptionsDialogue> {
  @override
  Widget build(BuildContext context) {
    final state = widget.provider == null ? null : ref.watch(widget.provider!);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.icon ?? const Icon(Icons.done),
          const SizedBox(height: 5),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              const Spacer(),
              state != null &&
              state.dialogueLoader == Loader.loading
                  ? const AppLoading(size: 20)
                  : Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.amber,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 100,
                height: 40,
                child: TextButton(
                  onPressed: state != null && state.dialogueLoader == Loader.loading ? null : widget.onPressedDecline,
                  child: Text(
                    widget.declineText ?? 'Decline',
                    style: const TextStyle(
                      color: AppColors.purple,
                      letterSpacing: 0.3,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              state != null &&
              state.dialogueLoader == Loader.loading
                  ? const AppLoading(size: 20)
                  : Container(
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        border: Border.all(
                          color: AppColors.amber,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 100,
                      height: 40,
                      child: TextButton(
                        onPressed: state != null && state.dialogueLoader == Loader.loading ? null :  widget.onPressedproceed,
                        child: Text(
                          widget.proceedText ?? 'Proceed',
                          style: const TextStyle(
                            color: AppColors.white,
                            letterSpacing: 0.3,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
              const Spacer(),
            ],
          )
        ],
      ),
      // actions: [

      // ],
    );
  }
}