import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_model.freezed.dart';
part 'product_model.g.dart';


@freezed
class ProductModel with _$ProductModel{
  const factory ProductModel({
   final List<Product>? products,
   final num? total,
   final num? skip,
   final num? limit,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}


@freezed
class Product with _$Product{
  const factory Product({
    final num? id,
    final String? title,
    final String? thumbnail, 
    final String? description,
    final String? category,
    final num? rating,
    final num? price,
    final List<String>? tags,

  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}