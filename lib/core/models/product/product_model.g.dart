// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      price: json['price'] as num?,
      quantity: json['quantity'] as int?,
      obtained: json['obtained'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'price': instance.price,
      'quantity': instance.quantity,
      'obtained': instance.obtained,
    };
