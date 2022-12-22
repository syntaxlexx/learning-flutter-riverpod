import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum NetworkStatus { notDetermined, on, off }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  late NetworkStatus lastResult;

  NetworkDetectorNotifier() : super(NetworkStatus.notDetermined) {
    lastResult = NetworkStatus.notDetermined;

    Connectivity().onConnectivityChanged.listen((result) {
      // Use Connectivity() here to gather more info if you need to
      NetworkStatus? newState;
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = NetworkStatus.on;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.off;
          // TODO: Handle this case.
          break;
        case ConnectivityResult.bluetooth:
          // TODO: Handle this case.
          break;
        case ConnectivityResult.ethernet:
          // TODO: Handle this case.
          break;
      }

      if (newState != state) {
        state = newState as NetworkStatus;
      }
    });
  }
}

final networkAwareProvider =
    StateNotifierProvider.autoDispose((ref) => NetworkDetectorNotifier());
