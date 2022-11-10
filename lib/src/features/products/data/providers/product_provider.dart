import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../exceptions/products_exception.dart';
import '../models/product_pagination.dart';
import '../repositories/product_repository.dart';
import '../utils/api_client.dart';

final productsRepositoryProvider = Provider<ProductRepository>(
  (ref) => ApiProductRepository(ApiClient().instance),
);

// add pagination state
final productsProvider =
    StateNotifierProvider<ProductPaginationNotifier, ProductPagination>((ref) {
  final repo = ref.watch(productsRepositoryProvider);

  return ProductPaginationNotifier(repo);
});

class ProductPaginationNotifier extends StateNotifier<ProductPagination> {
  final ProductRepository _repo;
  Timer _timer = Timer(const Duration(milliseconds: 0), () {});
  bool noMoreItems = false;
  int itemsPerBatch = 20;

  ProductPaginationNotifier(
    this._repo, [
    ProductPagination? state,
  ]) : super(state ?? ProductPagination.initial()) {
    getProducts(isInitialLoad: true);
  }

  Future<void> getProducts({bool isInitialLoad = false}) async {
    try {
      if (!isInitialLoad) {
        if (_timer.isActive && state.products.isNotEmpty) {
          state = state.copyWith(
            statusMessage: 'Debounced',
          );
          logger.i('Debounced');
          return;
        }

        _timer = Timer(const Duration(seconds: 1), () {});

        if (noMoreItems) {
          state = state.copyWith(
            statusMessage: 'No more Items',
          );
          logger.i('No more Items');
          return;
        }

        if (state.loading) {
          state = state.copyWith(
            statusMessage: 'Rejected. Already Loading',
          );
          logger.i('Rejected. Already Loading');
          return;
        }
        state = state.copyWith(
          statusMessage: 'Fetching Now',
        );
        logger.i('Fetching NOW');
      }

      state = state.copyWith(
        loading: true,
        errorMessage: '',
      );

      final products = await _repo.getProducts(state.page);
      noMoreItems = products.length < itemsPerBatch;

      state = state.copyWith(
        products: [...state.products, ...products],
        page: state.page + 1,
      );
    } on ProductsException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(
        loading: false,
        statusMessage: 'Completed',
      );
    }
  }

  void reset() {
    state = ProductPagination.initial();
    getProducts(isInitialLoad: true);
  }

  Future<void> recordView(int id) async {
    try {
      await _repo.recordView(id);

      // TODO: update state here
    } on ProductsException catch (e) {
      // fail silently
    } catch (e) {
      // fail silently
    }
  }

  Future<void> recordLike(int id) async {
    try {
      await _repo.likeProduct(id);

      // TODO: update state here
    } on ProductsException catch (e) {
      // fail silently
    } catch (e) {
      // fail silently
    }
  }
}
