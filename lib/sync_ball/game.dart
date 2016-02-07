part of sync_ball;

abstract class Game {
  State get state;
  Stream<State> get onUpdate;
  void pushState(State state);
}