import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/models/product.dart';
import '../data/providers/product_provider.dart';
import 'view_product_screen.dart';

class ProductItem extends ConsumerWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(productsProvider.notifier).recordView(product.id);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewProductScreen(product: product),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: 'photo-${product.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: FrontBanner(product: product),
          ),
          Positioned(
            top: 15.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_basket,
                        size: 15.0,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '\$${product.rating}',
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: Colors.white.withOpacity(0.8),
                        size: 15.0,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${product.stock}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FrontBanner extends StatelessWidget {
  final Product product;

  const FrontBanner({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(15),
        // bottomRight: Radius.circular(0),
        // topLeft: Radius.circular(0),
        topRight: Radius.circular(15),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          color: Colors.grey.shade900.withOpacity(0.7),
          padding: const EdgeInsets.all(7),
          margin: const EdgeInsets.only(bottom: 5),
          child: Center(
            child: Hero(
              tag: 'title-${product.id}',
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade200,
                    ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
