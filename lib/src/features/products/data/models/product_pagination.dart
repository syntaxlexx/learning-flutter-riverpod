import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'product.dart';

class ProductPagination extends Equatable {
  List<Product> products;
  int page;
  bool loading;
  String? errorMessage;
  String? statusMessage; // used to display message

  ProductPagination.initial()
      : products = [],
        page = 1,
        loading = false,
        errorMessage = '',
        statusMessage = '';

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  ProductPagination({
    required this.products,
    required this.page,
    required this.loading,
    this.errorMessage,
    this.statusMessage,
  });

  ProductPagination copyWith({
    List<Product>? products,
    int? page,
    bool? loading,
    String? errorMessage,
    String? statusMessage,
  }) {
    return ProductPagination(
      products: products ?? this.products,
      page: page ?? this.page,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'page': page,
      'loading': loading,
      'errorMessage': errorMessage,
      'statusMessage': statusMessage,
    };
  }

  factory ProductPagination.fromMap(Map<String, dynamic> map) {
    return ProductPagination(
      products: List<Product>.from(
        (map['movies'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      page: map['page'] as int,
      errorMessage: map['errorMessage'] as String,
      loading: map['loading'] as bool,
      statusMessage: map['statusMessage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPagination.fromJson(String source) =>
      ProductPagination.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductPagination(products: $products, page: $page, errorMessage: $errorMessage, statusMessage: $statusMessage)';

  @override
  List<Object?> get props {
    return [
      products,
      page,
      loading,
      errorMessage,
      statusMessage,
    ];
  }
}
