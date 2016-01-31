part of sync_ball;

class InfiniteClock implements Clock {

  StreamController<double> _onTick = new StreamController();
  Stream<double> get onTick => _onTick.stream;

  Duration _interval;
  Timer _timer;

  InfiniteClock(this._interval){
    _timer = new Timer.periodic(_interval, _handleTick);
  }

  void _handleTick(Timer timer) {
    _onTick.add(_interval.inMilliseconds / 1000);
  }
}