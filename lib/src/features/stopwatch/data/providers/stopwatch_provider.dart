import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/timer.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) => TimerNotifier(),
);

class TimerNotifier extends StateNotifier<TimerModel> {
  TimerNotifier() : super(_initialState);

  static const int _initialDuration = 10;
  static final _initialState = TimerModel(
    _durationString(_initialDuration),
    ButtonState.initial,
  );

  final _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  static String _durationString(int duration) {
    final minutes = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }

  void start() {
    if (state.buttonState == ButtonState.paused) {
      _restartTimer();
    } else {
      _startTimer();
    }
  }

  void _restartTimer() {
    _tickerSubscription?.resume();
    state = TimerModel(state.timeLeft, ButtonState.started);
  }

  void _startTimer() {
    _tickerSubscription?.cancel();

    _tickerSubscription =
        _ticker.tick(ticks: _initialDuration).listen((duration) {
      state = TimerModel(_durationString(duration), ButtonState.started);
    });

    _tickerSubscription?.onDone(() {
      state = TimerModel(state.timeLeft, ButtonState.finished);
    });

    state = TimerModel(_durationString(_initialDuration), ButtonState.started);
  }

  void pause() {
    _tickerSubscription?.pause();
    state = TimerModel(state.timeLeft, ButtonState.paused);
  }

  void reset() {
    _tickerSubscription?.cancel();
    state = _initialState;
  }
}

class Ticker {
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}

// This is a Provider instead of a StateNotifierProvider.
// The reason is that you’re listening to another provider rather than to a StateNotifier.

// watch only gives updates for unique changes.
//Since _buttonState will be the same for most of the timerProvider changes,
//watching _buttonState in the second provider will only cause rebuilds when _buttonState actually changes.
//Thus, buttonProvider will only be updated when the button state changes.
//You’ve effectively filtered out all of the timeLeft changes.
final buttonProvider = Provider<ButtonState>((ref) {
  return ref.watch(_buttonState);
});

final _buttonState = Provider<ButtonState>((ref) {
  return ref.watch(timerProvider).buttonState;
});

final timeLeftProvider = Provider<String>((ref) {
  return ref.watch(_timeLeftProvider);
});

final _timeLeftProvider = Provider<String>((ref) {
  return ref.watch(timerProvider).timeLeft;
});

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}
