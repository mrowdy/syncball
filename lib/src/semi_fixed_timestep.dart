part of sync_ball;

class SemiFixedTimestep {
  double _alpha = 0.0;
  double _timeStep;

  SemiFixedTimestep([this._timeStep = 0.0]);

  StreamController _onUpdate = new StreamController();
  Stream<double> get onUpdate => _onUpdate.stream;

  void addTime(double delta){
    _alpha += delta;

    while(_alpha >= _timeStep){
      _alpha -= _timeStep;
      _onUpdate.add(_timeStep);
    }
  }
}