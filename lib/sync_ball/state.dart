part of sync_ball;

abstract class State {

  /**
   * Build state with time and units
   */
  State(double time, List<Unit> units);

  /**
   * Get time of this state
   */
  double get time;

  /**
   * Get list of units
   */
  List<Unit> get units;

  /**
   * Convert state to json
   */
  Map toJson();

  /**
   * Build a state from a map (json to state)
   */
  State.fromMap(Map map);

  /**
   * Clone this state
   */
  State clone();
}