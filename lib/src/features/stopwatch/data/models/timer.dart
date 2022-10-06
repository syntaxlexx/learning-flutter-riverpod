class TimerModel {
  const TimerModel(this.timeLeft, this.buttonState);
  final String timeLeft;
  final ButtonState buttonState;
}

enum ButtonState {
  initial,
  started,
  paused,
  finished,
}
