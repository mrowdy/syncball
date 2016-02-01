part of sync_ball;

class PointServer implements Server {

  StreamController _onUpdate = new StreamController<State>();
  Stream<State> get onUpdate => _onUpdate.stream;

  Clock _clock;
  Game _game;

  PointServer(this._clock){
    _game = new Game(units: 10);
    _game.start();
    _clock.onTick.listen((_) => _send());
  }

  void _send(){
    _onUpdate.add(_game.state);
  }
}