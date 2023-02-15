import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/router/app_router.dart';
import 'package:inventory_app/widgets/my_circular_text_button.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            RoundedTextButton(
                color: AppColors.purple600,
                text: 'Add Product',
                press: () {
                  context.router.push(const AddProductScreenRoute());
                },),
            const SizedBox(height: 10),
            RoundedTextButton(
                color: AppColors.amber,
                text: 'Update Product Price',
                press: () {
                  context.router.push(const UpdateProductScreenRoute());
                },),
            const SizedBox(height: 10),
            RoundedTextButton(
                color: AppColors.purple,
                text: 'Add Product Quantity',
                press: () {
                  context.router.push(const UpdateProductScreenRoute());
                },),
            const SizedBox(height: 10),
            RoundedTextButton(
                color: AppColors.amber,
                text: 'Reduce Product Quantity',
                press: () {
                  context.router.push(const UpdateProductScreenRoute());
                },),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
