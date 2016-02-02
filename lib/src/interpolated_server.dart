part of sync_ball;

class InterpolatedServer implements Server, Screen {

  Clock _clock;
  double _time = 0.0;
  Duration _delay;

  StateBuffer _stateBuffer = new StateBuffer();

  StreamController _onUpdate = new StreamController<State>();
  Stream<State> get onUpdate => _onUpdate.stream;

  InterpolatedState _iState;

  InterpolatedServer(this._clock, this._delay){
    _iState = new InterpolatedState(_stateBuffer);
    _clock.onTick.listen(_update);
  }

  void pushState(State state){
    _stateBuffer.pushState(state);
  }

  void _update(double delta){
    if(_delay.inMilliseconds > 0){
      _delay = new Duration(milliseconds: _delay.inMilliseconds - (delta * 1000).toInt());
      return;
    }

    _time = num.parse((_time + delta).toStringAsFixed(3));
    _iState.updateTime(_time);
    _onUpdate.add(_iState);
  }
}