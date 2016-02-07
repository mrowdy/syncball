part of sync_ball;

abstract class Server {

  /**
   * Stream of updated game states
   */
  Stream<State> get onUpdate;

  /**
   * Get the current state of the game
   */
  State get state;
}