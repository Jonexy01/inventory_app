import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@Freezed()
abstract class Product implements _$Product{
  const Product._();

  const factory Product({
    String? id,
    String? name,
    int? quantity,
    @Default(false) bool obtained,
  }) = _Product;

  ///returns product with a name with obtained set to false
  factory Product.empty() => const Product(name: '');

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.fromDocument(DocumentSnapshot doc) {
    if (doc.data() == null) {return const Product();}
    final data = doc.data() as Map<String, dynamic>;
    return Product.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');

}