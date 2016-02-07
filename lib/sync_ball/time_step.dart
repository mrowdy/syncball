part of sync_ball;

/**
 * Abstraction for time stepping
 */
abstract class TimeStep {
  Stream<double> get onUpdate;
  void addTime(double delta);
}