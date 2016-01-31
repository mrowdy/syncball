part of client;

class CanvasScreen implements Screen {

  Clock _clock;
  CanvasElement _canvas;
  CanvasRenderingContext2D _context;

  State _state;

  void pushState(State state) {
    _state = state;
  }

  CanvasScreen(this._canvas, this._clock){
    _context = _canvas.context2D;
    _clock.onTick.listen(_render);
  }

  void _render(double delta){
    _clearScreen();

    if(_state == null){
      return;
    }

    _drawUnits(_state.units);
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

