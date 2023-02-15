import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:inventory_app/widgets/dropdown_bottomsheet.dart';

class UpdateProductScreen extends StatefulHookConsumerWidget {
  const UpdateProductScreen({ Key? key }) : super(key: key);

  @override
  ConsumerState<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends ConsumerState<UpdateProductScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(manageProductsViewModel.notifier);
  }

  @override
  Widget build(BuildContext context) {

    final productValue = useState('');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product Price'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          DropDownWithBottomSheet(myvalue: productValue),
        ],
      ),
    );
  }
}