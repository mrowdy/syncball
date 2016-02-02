part of sync_ball;

class Clock {

  StreamController<double> _onTick = new StreamController();
  Stream<double> get onTick => _onTick.stream;

  Duration _interval;
  int _count;
  Timer _timer;

  Clock(this._count, this._interval){
    _createTimer();
  }

  void _createTimer() {
    _timer = new Timer.periodic(_interval, _handleTick);
  }

  void _handleTick(Timer timer) {
    _count--;
    _onTick.add(_interval.inMilliseconds.toDouble() * 1000);
    if(_count <= 0){
      _timer.cancel();
    }
  }
}