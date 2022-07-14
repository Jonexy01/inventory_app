import 'package:firebase_core/firebase_core.dart';
import 'package:inventory_app/core/services/firebase_firestore_extension.dart';
import 'package:inventory_app/core/models/product/product_model.dart';
import 'package:inventory_app/providers/app_providers.dart';
import 'package:riverpod/riverpod.dart';

abstract class ProductBaseCrud {
  Future<List<Product>> retrieveAllProducts({required String userId});
  Future<String> insertProduct({required String userId, required Product product});
  Future<void> updateProduct({required String userId, required Product product});
  Future<void> deleteProduct({required String userId, required String productId});
}

class ProductCrud implements ProductBaseCrud {
  final Reader _read;

  const ProductCrud(this._read);

  @override
  Future<List<Product>> retrieveAllProducts({required String userId}) async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).userProductsRef(userId).get();
      return snap.docs.map((doc) => Product.fromDocument(doc)).toList();
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> insertProduct(
      {required String userId, required Product product}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userProductsRef(userId)
          .add(product.toDocument());
      return docRef.id;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(
      {required String userId, required Product product}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userProductsRef(userId)
          .doc(product.id)
          .update(product.toDocument());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(
      {required String userId, required String productId}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userProductsRef(userId)
          .doc(productId)
          .delete();
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
