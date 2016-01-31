part of sync_ball;

class InterpolatedState implements State {
  List<State> _states = new List<State>();
  Interpolator _interpolator = new Hermit();

  State _state = new State(0.0, new List<Unit>());

  double get time => _state.time;
  List<Unit> get units => _state.units;

  bool get isValid => _states.length > 3;

  double get minTime => _states.elementAt(_states.length - 3).time;
  double get maxTime => _states.elementAt(_states.length - 2).time;

  void pushState(State state){
    _states.add(state);
    if(_states.length > 4){
      _states.removeAt(0);
    }
  }

  void updateTime(double time){
    if(_states.length > 3){
      _state = _interpolateState(
          time,
          _states.elementAt(_states.length - 4),
          _states.elementAt(_states.length - 3),
          _states.elementAt(_states.length - 2),
          _states.elementAt(_states.length - 1)
      );
    }
  }

  Vector2 _interpolateVector2(Vector2 v1, Vector2 v2, Vector2 v3, Vector2 v4, double mu){
    return new Vector2(
        _interpolator.interpolate(v1.x, v2.x, v3.x, v4.x, mu),
        _interpolator.interpolate(v1.y, v2.y, v3.y, v4.y, mu)
    );
  }

  Unit _interpolateUnit(Unit u1, Unit u2, Unit u3, Unit u4, double mu){
    Unit u0 = new Unit(u1.id);
    u0.position = _interpolateVector2(u1.position, u2.position, u3.position, u4.position, mu);
    u0.size = u1.size;
    return u0;
  }

  State _interpolateState(double time, State s1, State s2, State s3, State s4){
    double mu = (time - s2.time) / (s3.time - s2.time);

    List<Unit> units = new List<Unit>();

    for(int i = 0; i < s1.units.length; i++){
      units.add(_interpolateUnit(s1.units[i], s2.units[i], s3.units[i], s4.units[i], mu));
    }

    return new State(time, units);
  }

  @override
  Map toJson() => _state.toJson();

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}