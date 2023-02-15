import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/product/product_model.dart';
import 'package:inventory_app/core/services/service_utils.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/core/utils/validator.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/widgets/alert_flushbar.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';
import 'package:inventory_app/widgets/my_rounded_input_field.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(manageProductsViewModel);
    final model = ref.read(manageProductsViewModel.notifier);
    final user = ref.read(authViewModelProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                RoundedInputField(
                  hintText: 'Product Name',
                  controller: _nameController,
                  validator: (value) => FieldValidator.validateField(value!),
                ),
                const SizedBox(height: 15),
                RoundedInputField(
                  hintText: 'Type',
                  controller: _typeController,
                  validator: (value) => FieldValidator.validateField(value!),
                ),
                const SizedBox(height: 15),
                RoundedInputField(
                  hintText: 'Price in Naira',
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) => FieldValidator.validateField(value!),
                ),
                const SizedBox(height: 15),
                RoundedInputField(
                  hintText: 'Quantity',
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  validator: (value) => FieldValidator.validateField(value!),
                ),
                const SizedBox(height: 25),
                RoundedTextButton(
                  isLoading: state.loadStatus == Loader.loading,
                  text: 'Add',
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await model.addProduct(
                        userId: user!.uid,
                        product: Product(
                          name: _nameController.text,
                          type: _typeController.text,
                          price: num.parse(_priceController.text),
                          quantity: int.parse(_quantityController.text),
                        ),
                      );
                      if (response.successMessage.isNotEmpty) {
                        _nameController.clear();
                        _typeController.clear();
                        _priceController.clear();
                        _quantityController.clear();
                        AlertFlushbar.showNotification(
                          context: context,
                          message: response.successMessage,
                        );
                      } else {
                        handleError(
                            e: response.error ?? response.errorMessage,
                            context: context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
