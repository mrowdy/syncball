part of sync_ball;

abstract class Game {

  /**
   * Current state of the game
   */
  State get state;

  /**
   * Stream of updated game states
   */
  Stream<State> get onUpdate;

  /**
   * Set the game to a new state (think: loading a savegame)
   */
  void pushState(State state);
}