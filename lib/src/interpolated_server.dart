part of sync_ball;

class InterpolatedServer implements Server, Screen {

  Clock _clock;
  double _time = 0.0;

  double _delay = 0.200;

  StateBuffer _stateBuffer = new StateBuffer();

  StreamController _onUpdate = new StreamController<State>();
  Stream<State> get onUpdate => _onUpdate.stream;

  InterpolatedState _iState;

  InterpolatedServer(this._clock){
    _iState = new InterpolatedState(_stateBuffer);
    _clock.onTick.listen(_update);
  }

  void pushState(State state){
    _stateBuffer.pushState(state);
  }

  void _update(double delta){
    if(_delay > 0){
      _delay -= delta;
      return;
    }

    _time += delta;
    _iState.updateTime(_time);
    _onUpdate.add(_iState);
  }
}