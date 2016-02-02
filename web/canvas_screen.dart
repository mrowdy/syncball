part of client;

class CanvasScreen implements Screen {

  Clock _clock;
  CanvasElement _canvas;
  CanvasRenderingContext2D _context;

  double _minSize;
  State _state;

  double _width;
  double _height;

  double _gameRatio;

  void pushState(State state) {
    _state = state;
  }

  CanvasScreen(this._canvas, this._clock){
    _events();
    _calcDimensions();
    _context = _canvas.context2D;
    _clock.onTick.listen(_render);
  }

  void _events() {
    window.onResize.listen((_) => _calcDimensions());
  }

  void _calcDimensions() {
    _width = _canvas.client.width.toDouble();
    _height = _canvas.client.height.toDouble();
    _resize();
    _minSize = min(_width, _height);
    _gameRatio = _minSize / 100;
  }

  void _resize() {
    _canvas.width = _width.toInt();
    _canvas.height = _height.toInt();
  }

  void _render(double delta){
    _clearScreen();

    if(_state == null){
      return;
    }

    _toGameSpace();
    _drawBackground();
    _drawUnits(_state.units);
    _toWorldSpace();
  }

  void _drawBackground() {
    _context.fillStyle = '#550000';
    _context.fillRect(0,0,100,100);
    _context.fillStyle = '#000000';
    _context.fillRect(1,1,98,98);
  }

  void _toWorldSpace() {
    _context.scale(_gameRatio * -1, _gameRatio * -1);
    _context.restore();
  }

  void _toGameSpace() {
    _context.save();
    _context.translate(_width / 2 - _minSize / 2, _height / 2 - _minSize / 2);
    _context.scale(_gameRatio, _gameRatio);
  }

  void _clearScreen() {
    _context
      ..fillStyle = '#000000'
      ..strokeStyle = '#ffffff'
      ..clearRect(0,0,_canvas.width,_canvas.height)
      ..fillRect(0,0,_canvas.width,_canvas.height);
  }

  void _drawUnits(List<Unit> units) {
    units.forEach(_drawUnit);
  }

  void _drawUnit(Unit unit) {
    _context
      ..fillStyle = '#ff0000'
      ..strokeStyle = '#00ffff'
      ..beginPath()
      ..arc(unit.position.x, unit.position.y, unit.size, 0, 2 * PI)
      ..stroke()
      ..closePath();
  }
}

