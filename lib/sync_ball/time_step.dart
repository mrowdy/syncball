part of sync_ball;

abstract class TimeStep {
  Stream<double> get onUpdate;
  void addTime(double delta);
}