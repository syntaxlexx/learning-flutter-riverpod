import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { NotDetermined, On, Off }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  late NetworkStatus lastResult;

  NetworkDetectorNotifier() : super(NetworkStatus.NotDetermined) {
    lastResult = NetworkStatus.NotDetermined;

    Connectivity().onConnectivityChanged.listen((result) {
      // Use Connectivity() here to gather more info if you need to
      NetworkStatus? newState;
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = NetworkStatus.On;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.Off;
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
    StateNotifierProvider((ref) => NetworkDetectorNotifier());
