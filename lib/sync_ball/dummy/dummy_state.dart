part of sync_ball;

class DummyState implements State {

  double _time;
  List<Unit> _units = new List<Unit>();

  DummyState(this._time, this._units);

  double get time => _time;
  List<Unit> get units => _units;

  String toString(){
    return {
      "time": _time
    }.toString();
  }

  Map toJson() => {
    "time": _time,
    "units": _units,
  };

  DummyState.fromMap(Map map){
    _time = map['time'];
    map['units'].forEach((Map unitMap){
      _units.add(new Unit.fromMap(unitMap));
    });
  }

  State clone(){
    return new DummyState.fromMap(JSON.decode(JSON.encode(this)));
  }
}