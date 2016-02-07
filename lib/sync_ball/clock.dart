part of sync_ball;

abstract class Clock {
  Stream<double> get onTick;
}