part of sync_ball;

/**
 * Buffer states for a given time
 */
abstract class TimeBuffer {

  /**
   * Push state on top of buffer. Old states should be discarded
   */
  void pushState(State state);

  /**
   * Get the index of the newest state near the given time
   */
  int indexAtTime(double time);

  /**
   * Get element at index
   */
  State elementAt(int index);

  /**
   * Get current length of buffer
   */
  int get length;
}

