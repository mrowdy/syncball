part of sync_ball;

class Game {
  bool _isRunning = false;
  bool _isPaused = true;
  State _state;
  Clock _clock;

  SemiFixedTimestep _timeStep = new SemiFixedTimestep(0.01);
  Stopwatch _stopwatch = new Stopwatch();
  double _time = 0.0;

  double _worldWidth = 600.0;
  double _worldHeight = 600.0;

  int _unitCount;

  bool get isPaused => _isPaused;
  bool get isRunning => _isRunning;
  State get state => _state;

  StreamController<State> _onUpdate = new StreamController();
  Stream<State> get onUpdate => _onUpdate.stream;

  State _createState() => new State(0.0, _createUnits(_unitCount));

  Game({int units: 0, Clock clock: null}){
    _unitCount = units;
    _getClock(clock);

    _clock.onTick.listen(_tick);
    _timeStep.onUpdate.listen(_update);
    _state = _createState();
  }

  Game.fromState(State state, {Clock clock: null}){
    _getClock(clock);
    _clock.onTick.listen(_tick);
    _timeStep.onUpdate.listen(_update);
    _state = state;
  }

  void _getClock(Clock clock) {
       if(clock == null){
      _clock = new InfiniteClock(new Duration(milliseconds: 16));
    } else {
      _clock = clock;
    }
  }

  List<Unit> _createUnits(int count) {
    List<Unit> units = new List<Unit>();

    for(int i = 1; i <= count; i++) {
      Unit unit = new Unit(i);
      unit.size = 5.0;

      unit.position = new Vector2(
          _worldWidth / count * i - _worldWidth / count / 2,
          _worldHeight / 2
      );

      unit.velocity = new Vector2(
          0.0,
          3.0 * i
      );

      units.add(unit);
    }
    return units;
  }

  void _tick(double clockTime){
    if(!_isRunning || _isPaused){
      return;
    }

    double newTime = _stopwatch.elapsedMicroseconds / 1000000;
    _timeStep.addTime(newTime - _time);
    _time = newTime;
  }

  void _update(double delta){
    _state = new State(_time, _updateUnits(_state.units, delta));
    _onUpdate.add(_state);
  }

  void start(){
    _isRunning = true;
    _isPaused = false;
    _stopwatch.start();
  }

  void stop(){
    _isRunning = false;
    _isPaused = true;
    _state = _createState();
    _stopwatch.stop();
    _stopwatch.reset();
    _time = 0.0;
  }

  void pause(){
    _stopwatch.stop();
    _isPaused = true;
  }

  void resume(){
    _stopwatch.start();
    _isPaused = false;
  }

  List<Unit> _updateUnits(List<Unit> units, double delta) {
    units.forEach((unit) => _updateUnit(unit, delta));
    return units;
  }

  void _updateUnit(Unit unit, double delta){
    _checkWorldCollision(unit);
    unit.update(delta);
  }

  void _checkWorldCollision(Unit unit){
    if(unit.position.x - unit.size < 0){
      unit.position.x = 0.0 + unit.size;
      unit.velocity.x *= -1;
    }

    if(unit.position.x + unit.size > _worldWidth){
      unit.position.x = _worldWidth - unit.size;
      unit.velocity.x *= -1;
    }

    if(unit.position.y - unit.size < 0){
      unit.position.y = 0.0 + unit.size;
      unit.velocity.y *= -1;
    }

    if(unit.position.y + unit.size > _worldHeight){
      unit.position.y = _worldHeight - unit.size;
      unit.velocity.y *= -1;
    }
  }
}