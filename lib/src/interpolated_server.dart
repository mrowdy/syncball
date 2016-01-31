part of sync_ball;

class InterpolatedServer implements Server, Screen {

  Clock _clock;
  double _time = 0.0;

  bool _started = false;

  StateBuffer _stateBuffer = new StateBuffer();

  StreamController _onUpdate = new StreamController<State>();
  Stream<State> get onUpdate => _onUpdate.stream;

  InterpolatedState _iState = new InterpolatedState();

  InterpolatedServer(this._clock){
    _clock.onTick.listen(_update);
  }

  void pushState(State state){
    _iState.pushState(state);
    _stateBuffer.pushState(state);
    _syncServerTime();
  }

  void _update(double delta){

    if(!_iState.isValid){
      return;
    }

    if(!_started){
      _started = true;
      _syncServerTime();
    }

    //print('game time: '  + _time.toString() );
    _iState.updateTime(_time);
    _onUpdate.add(_iState);
    _time += delta;
  }

  void _syncServerTime() {
    if(_iState.isValid){
      _time = _iState.minTime;
    }
  }
}