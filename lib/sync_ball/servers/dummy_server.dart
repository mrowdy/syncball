part of sync_ball;

class DummyServer implements Server {

  StreamController _onUpdate = new StreamController<State>.broadcast();
  Stream<State> get onUpdate => _onUpdate.stream;

  Clock _clock;
  Game _game;

  DummyServer(this._clock){
    _game = new DummyGame(units: 10, clock: _clock);
    _clock.onTick.listen((_) => _send());
  }

  void _send(){
    _onUpdate.add(_game.state.clone());
  }

  State get state => _game.state.clone();
}