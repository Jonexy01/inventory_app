import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inventory_app/core/models/product/product_model.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:riverpod/riverpod.dart';

class ManageProductsViewModel extends StateNotifier<ManageProductsState> {
  ManageProductsViewModel(this._reader) : super(ManageProductsState());

  final Reader _reader;

  Future<ServiceResponse> addProduct({required String userId, required Product product,}) async {
    state = state.copyWith(loadStatus: Loader.loading);
    if (!(await checkNetwork())) {
      return ServiceResponse(errorMessage: enableConnection);
    }
    try {
      await _reader(productCrudProvider).insertProduct(userId: userId, product: product);
      state = state.copyWith(loadStatus: Loader.loaded);
      return ServiceResponse(
          successMessage: 'Product added successfuly');
    } on FirebaseException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<ServiceResponse> fetchAllProducts({required String userId,}) async {
    state = state.copyWith(loadStatus: Loader.loading);
    if (!(await checkNetwork())) {
      return ServiceResponse(errorMessage: enableConnection);
    }
    try {
      final response = await _reader(productCrudProvider).retrieveAllProducts(userId: userId);
      state = state.copyWith(loadStatus: Loader.loaded, products: response,);
      return ServiceResponse(
          successMessage: 'Product added successfuly');
    } on FirebaseException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<bool> checkNetwork() async {
    final cResult = await Connectivity().checkConnectivity();
    if (cResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}


class ManageProductsState {
  ManageProductsState({this.loadStatus, this.products,});

  Loader? loadStatus;
  List<Product>? products;

  ManageProductsState copyWith({Loader? loadStatus, List<Product>? products,}) {
    return ManageProductsState(
      loadStatus: loadStatus ?? this.loadStatus,
      products: products ?? this.products,
    );
  }

}