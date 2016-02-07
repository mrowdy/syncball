part of sync_ball;

abstract class Clock {

  /**
   * A tick of a clock. Returns elapsed time
   */
  Stream<double> get onTick;
}