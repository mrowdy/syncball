part of sync_ball;

class State {

  double _time;
  List<Unit> _units = new List<Unit>();

  State(this._time, this._units);

  double get time => _time;
  List<Unit> get units => _units;

  String toString(){
    return {
      "time": _time,
      "units": _units
    }.toString();
  }

  Map toJson() => {
    "time": _time,
    "units": _units
  };

  State.fromMap(Map map){
    _time = map['time'];
    map['units'].forEach((Map unitMap){
      _units.add(new Unit.fromMap(unitMap));
    });
  }
}