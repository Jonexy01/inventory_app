import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/core/utils/validator.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';
import 'package:inventory_app/widgets/my_rounded_input_field.dart';

class StopoverPage extends ConsumerStatefulWidget {
  const StopoverPage({Key? key}) : super(key: key);

  @override
  ConsumerState<StopoverPage> createState() => _StopoverPageState();
}

class _StopoverPageState extends ConsumerState<StopoverPage> {
  final businessNameController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);
    final model = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text('Kindly provide information'),
              const SizedBox(height: 10),
              RoundedInputField(
                hintText: 'Enter your name/username',
                controller: nameController,
                validator: (value) => FieldValidator.validateField(value!),
              ),
              const SizedBox(height: 10),
              RoundedInputField(
                hintText: 'Enter your business name',
                controller: businessNameController,
                validator: (value) => FieldValidator.validateField(value!),
              ),
              const SizedBox(height: 10),
              RoundedTextButton(
                isLoading: state.loadStatus == Loader.loading,
                text: 'Proceed',
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    final response =
                        await model.updateUserDisplayName(nameController.text);
                    if (response.successMessage.isEmpty) {
                      handleError(
                          e: response.error ?? response.errorMessage,
                          context: context);
                    }
                    model.fetchCurrrentUser();
                    model
                        .updateUserProfile(
                            role: 'primary',
                            userId: state.user!.uid,
                            businessName: businessNameController.text,
                            name: nameController.text,
                            email: state.user!.email!,
                            )
                        .then((value) {
                      if (value.successMessage.isNotEmpty) {
                        SchedulerBinding.instance!
                            .addPostFrameCallback((timeStamp) {
                          AlertFlushbar.showNotification(
                              message: value.successMessage, context: context);
                        });
                        context.router.replace(const HomePageRoute());
                      } else {
                        SchedulerBinding.instance!
                            .addPostFrameCallback((timeStamp) {
                          handleError(
                              e: value.error ?? value.errorMessage,
                              context: context);
                        });
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: width(context) * 0.8,
                child: const Text(
                  'You can add secondary users under menu after providing the secondary user with your email for registration',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
