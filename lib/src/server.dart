part of sync_ball;

class Server {
  StreamController _onUpdate = new StreamController<State>();
  Stream<State> get onUpdate => _onUpdate.stream;
}