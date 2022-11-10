import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String? description;
  final int price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final String thumbnail;
  final List<String> images;

  const Product({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    required this.thumbnail,
    required this.images,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    int? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    String? brand,
    String? category,
    String? thumbnail,
    List<String>? images,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: int.parse(map['id'].toString()),
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: int.parse(map['price'].toString()),
      discountPercentage: map['discountPercentage'] != null
          ? map['discountPercentage'] as double
          : null,
      rating:
          map['rating'] != null ? double.parse(map['rating'].toString()) : null,
      stock: map['stock'] != null ? int.parse(map['stock'].toString()) : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      thumbnail: map['thumbnail'] as String,
      images: (map['images'] as List).map((e) => e as String).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      price,
      discountPercentage,
      rating,
      stock,
      brand,
      category,
      thumbnail,
      images,
    ];
  }
}
