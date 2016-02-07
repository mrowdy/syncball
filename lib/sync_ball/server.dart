part of sync_ball;

abstract class Server {
  StreamController _onUpdate;
  Stream<State> get onUpdate;
  State get state;
}