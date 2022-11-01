import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/validator.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';
import 'package:inventory_app/widgets/my_rounded_input_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
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
                  validator: (value) => FieldValidator.validateField(value!),
                ),
                const SizedBox(height: 15),
                RoundedInputField(
                  hintText: 'Quantity',
                  controller: _quantityController,
                  validator: (value) => FieldValidator.validateField(value!),
                ),
                const SizedBox(height: 25),
                RoundedTextButton(
                  text: 'Add',
                  press: () {
                    if (_formKey.currentState!.validate()) {}
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
