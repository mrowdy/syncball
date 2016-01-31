part of client;

class FrameClock implements Clock {
  StreamController<double> _onTick = new StreamController();
  Stream<double> get onTick => _onTick.stream;

  FrameClock(){
    _handleFrame(0.0);
  }

  void _handleFrame(double delta){
    window.animationFrame.then(_handleFrame);
    _onTick.add(delta);
  }
}