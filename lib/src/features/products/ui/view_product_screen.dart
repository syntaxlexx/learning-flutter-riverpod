import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/models/product.dart';
import '../data/providers/cart_provider.dart';

class ViewProductScreen extends ConsumerWidget {
  final Product product;

  const ViewProductScreen({Key? key, required this.product}) : super(key: key);

  static const route = '/viewproduct';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final cart = ref.watch(cartProvider);

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'photo-${product.id}',
            child: Container(
              width: size.width,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    product.thumbnail,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 30 + MediaQuery.of(context).padding.top,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: ClipOval(
                child: Container(
                  height: 42,
                  width: 41,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: const Offset(0, -4),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                product.title,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                            const Icon(
                              Icons.favorite,
                              size: 22,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${product.price}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Row(
                              children: List.generate(
                                  product.rating!.toInt(),
                                  ((index) => const Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.yellow,
                                      ))),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(63, 200, 101, 1),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            'Shipped directly from our farmers',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                ref.read(cartProvider.notifier).state--;
                                if (cart <= 0) {
                                  ref.read(cartProvider.notifier).state = 1;
                                }
                              },
                              child: Container(
                                height: 49,
                                width: 49,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(228, 228, 228, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(Icons.remove),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 49,
                              child: Center(
                                child: Text(
                                  '${cart}',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                ref.read(cartProvider.notifier).state++;
                              },
                              child: Container(
                                height: 49,
                                width: 49,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(243, 175, 45, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.07),
                          offset: const Offset(0, -3),
                          blurRadius: 12,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w200,
                                  ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '\$${product.price * cart}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            print('Clicked');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Add to Cart',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
