import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/notification_model/notification_model.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/core/utils/validator.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';
import 'package:inventory_app/widgets/my_rounded_input_field.dart';

class StopoverAddUserPage extends ConsumerStatefulWidget {
  const StopoverAddUserPage({Key? key}) : super(key: key);

  @override
  ConsumerState<StopoverAddUserPage> createState() =>
      _StopoverAddUserPageState();
}

class _StopoverAddUserPageState extends ConsumerState<StopoverAddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

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
                hintText: 'Enter the email of the primary user',
                validator: (value) => EmailValidator.validateEmail(value!),
                controller: emailController,
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
                    final primaryUserResponse = await model.fetchPrimaryUser(email: emailController.text);
                    if (primaryUserResponse.successMessage.isNotEmpty) {
                      model
                        .updateUserProfile(
                      businessName: ref.read(authViewModelProvider).primaryUserRecord!.businessName!,
                      role: 'secondary',
                      userId: state.user!.uid,
                      name: nameController.text,
                      email: state.user!.email!,
                    )
                        .then((value) {
                      if (value.successMessage.isNotEmpty) {
                        model.notifyPrimaryUser(
                          notification: NotificationModel(
                            title: 'Approve Secondary User',
                            body: 'Click to Approve or Decline',
                            userCategory: 'primary',
                            primaryId: ref.read(authViewModelProvider).primaryUserRecord!.id,
                            userNotifying: ref.read(authViewModelProvider).user!.displayName,
                            userIdNotifying: ref.read(authViewModelProvider).user!.uid,
                            notificationType: 'SecondaryApproval'
                          ),
                        );
                        SchedulerBinding.instance!
                            .addPostFrameCallback((timeStamp) {
                          AlertFlushbar.showNotification(
                              message: value.successMessage, context: context);
                        });
                        context.router.replace(const SecondaryWaitPageRoute());
                      } else {
                        SchedulerBinding.instance!
                            .addPostFrameCallback((timeStamp) {
                          handleError(
                              e: value.error ?? value.errorMessage,
                              context: context);
                        });
                      }
                    });
                    } else {
                      handleError(
                          e: primaryUserResponse.error ?? primaryUserResponse.errorMessage,
                          context: context);
                    }
                    
                  }
                },
              ),
              const SizedBox(height: 10),
              const Text(
                  '''An email will be sent to the primary user for approval. 
              '''),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
