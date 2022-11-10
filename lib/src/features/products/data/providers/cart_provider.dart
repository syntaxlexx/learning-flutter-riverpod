import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Cart provider should handle everything pertaining to cart
/// but for simplicity most functionality shall not be provided

final cartProvider = StateProvider<int>((ref) => 0);
