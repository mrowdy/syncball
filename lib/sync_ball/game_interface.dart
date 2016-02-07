part of sync_ball;

abstract class GameInterface {

  State get state;
  Stream<State> get onUpdate;
  void pushState(State state);
}