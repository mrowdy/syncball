part of sync_ball;

class InterpolatedServer implements Server, Screen {

  Clock _clock;
  double _time = 0.0;
  double _delay;
  bool _isRunning = false;

  InterpolatedState _iState;

  Stopwatch _stopwatch = new Stopwatch();
  StateBuffer _stateBuffer = new StateBuffer(ttl: 10.0);
  StreamController _onUpdate = new StreamController<State>();
  Stream<State> get onUpdate => _onUpdate.stream;

  InterpolatedServer(this._clock, this._delay){
    _iState = new InterpolatedState(_stateBuffer);
    _clock.onTick.listen(_handleTick);
  }

  void pushState(State state){
    _stateBuffer.pushState(state);
  }

  void _handleTick(double delta){
    _startDelayed(delta);

    if(_isRunning){
      _update();
    }
  }

  void _startDelayed(double delta) {
    if(_delay > 0){
      _delay -= delta;
      return;
    }

    if(!_isRunning){
      _stopwatch.start();
      _isRunning = true;
    }
  }

  void _update(){
    _iState.updateTime(_stopwatch.elapsedMicroseconds / 1000000);
    _onUpdate.add(_iState);
  }

  State get state => _iState;
}