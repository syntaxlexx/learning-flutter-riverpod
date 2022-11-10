import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/providers/product_provider.dart';
import 'loading.dart';
import 'product_item.dart';

class ProductsScreen extends ConsumerWidget {
  ProductsScreen({Key? key}) : super(key: key);
  static const route = '/products';

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusMessage =
        ref.watch(productsProvider.select((value) => value.statusMessage));

    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.02;
      if (maxScroll - currentScroll <= delta) {
        ref.read(productsProvider.notifier).getProducts();
      }
    });

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ScrollToTopButton(
          scrollController: scrollController,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(productsProvider.notifier).reset();
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Products'),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Network Status: $statusMessage',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            const ItemsListBuilder(),
            const OnGoingBottomWidget(),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double scrollOffset = scrollController.offset;
        double trigger = MediaQuery.of(context).size.height * 0.3;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: scrollOffset > trigger * 0.2
              ? FloatingActionButton(
                  tooltip: 'Scroll to top',
                  child: const Icon(
                    Icons.arrow_upward,
                  ),
                  onPressed: () async {
                    await scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

class ItemsListBuilder extends ConsumerWidget {
  const ItemsListBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productPagination = ref.watch(productsProvider);

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = productPagination.products[index];
          return ProductItem(
            product: item,
          );
        },
        childCount: productPagination.products.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
    );
  }
}

class OnGoingBottomWidget extends StatelessWidget {
  const OnGoingBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final hasError = ref
                    .watch(productsProvider.select((value) => value.hasError));
                return hasError
                    ? Column(
                        children: const [
                          Icon(Icons.info),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Something Went Wrong!'),
                        ],
                      )
                    : const SizedBox.shrink();
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final loading = ref
                    .watch(productsProvider.select((value) => value.loading));
                return loading
                    ? Center(
                        child: Column(
                          children: const [
                            Loading(
                              rows: 8,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
