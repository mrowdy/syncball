part of sync_ball;

class PointServer implements Server {

  StreamController _onUpdate = new StreamController<State>();
  Stream<State> get onUpdate => _onUpdate.stream;

  double _time = 0.0;
  Stopwatch _stopWatch = new Stopwatch();

  Clock _clock;
  Clock _internalClock = new InfiniteClock(new Duration(milliseconds: 16));

  List<Unit> _units = new List<Unit>();

  double _worldWidth = 600.0;
  double _worldHeight = 600.0;

  PointServer(this._clock){
    _stopWatch.start();
    _createUnits();
    _clock.onTick.listen((_) => _send());
    _internalClock.onTick.listen((_) => _update());
  }

  void _update(){
    double currentTime = _stopWatch.elapsedMilliseconds / 1000;
    double delta = currentTime - _time;
    _time = currentTime;

    _updateUnits(delta);
  }

  void _send(){
    _addState();
  }

  void _createUnits() {
    for(int i = 1; i <= 20; i++){
      Unit unit = new Unit(i);
      unit.size = 5.0;

      unit.position = new Vector2(
          _worldWidth / 20 * i,
          _worldHeight / 2
      );

      unit.velocity = new Vector2(
          0.0,
          3.0 * i
      );

      _units.add(unit);
    }
  }

  void _updateUnits(double delta) {
    _units.forEach((unit) => _updateUnit(delta, unit));
  }

  void _updateUnit(double delta, Unit unit){
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

  void _addState() {
    State state = new State.fromMap(JSON.decode(JSON.encode(new State(_time, _units))));
    //print('server time: '  + _time.toString() );

    _onUpdate.add(state);
  }
}