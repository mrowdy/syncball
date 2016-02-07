part of sync_ball;

class UserData {
  int id;
  double size;
  UserData(this.id, this.size);
}

class Box2dGame implements GameInterface {

  List<Body> _bodies = new List<Body>();

  static const num TIME_STEP = 1 / 60;
  static const int VELOCITY_ITERATIONS = 10;
  static const int POSITION_ITERATIONS = 10;

  Stopwatch _stopwatch = new Stopwatch();

  World _world;
  Clock _clock;

  Random rand = new Random(1);

  StreamController _onUpdate = new StreamController.broadcast();

  int _unitCount;
  Stream<State> get onUpdate => _onUpdate.stream;

  void pushState(State state) {}
  State get state => _getState();

  Box2dGame({int units: 0, Clock clock: null}) {
    _getClock(clock);
    _unitCount = units;
    _world = new World.withGravity(new Vector2.zero());
    _createWalls();
    _createBalls();
    _stopwatch.start();
    _clock.onTick.listen(_step);
  }

  void _createWalls() {
    // Create shape
    final PolygonShape shape = new PolygonShape();

    // Define body
    final BodyDef bodyDef = new BodyDef();
    bodyDef.position.setValues(0.0, 0.0);

    // Create body
    Body ground = _world.createBody(bodyDef);
    shape.setAsBoxXY(100.0, 1.0);
    ground.createFixtureFromShape(shape);

    shape.setAsBox(100.0, 1.0, new Vector2(0.0, 100.0), 0.0);
    ground.createFixtureFromShape(shape);

    shape.setAsBox(1.0, 100.0, new Vector2(100.0, 0.0), 0.0);
    ground.createFixtureFromShape(shape);

    shape.setAsBox(1.0, 100.0, new Vector2(0.0, 0.0), 0.0);
    ground.createFixtureFromShape(shape);
  }

  void _createBalls() {


    for(int i = 0; i < _unitCount; i++){

      final bouncingCircle = new CircleShape();
      bouncingCircle.radius = 1 + rand.nextDouble() * 3;

      // Create fixture for that ball shape.
      final activeFixtureDef = new FixtureDef();
      activeFixtureDef.restitution = 1.0;
      activeFixtureDef.density = 1.0;
      activeFixtureDef.shape = bouncingCircle;

      BodyDef activeBodyDef = new BodyDef();
      activeBodyDef.linearVelocity = new Vector2(rand.nextDouble() * 20 + 50, rand.nextDouble() * 20 + 50);
      activeBodyDef.position = new Vector2(rand.nextDouble() * 100, rand.nextDouble() * 100);
      activeBodyDef.type = BodyType.DYNAMIC;
      activeBodyDef.bullet = true;
      final activeBody = _world.createBody(activeBodyDef);
      _bodies.add(activeBody);
      activeBody.createFixtureFromFixtureDef(activeFixtureDef);
      activeBody.userData = new UserData(i, bouncingCircle.radius);
    }
  }

  void _step(num timestamp){
    _world.stepDt(TIME_STEP, VELOCITY_ITERATIONS, POSITION_ITERATIONS);
    _onUpdate.add(_getState());
  }

  State _getState() {

    List<Unit> units = new List<Unit>();

    _bodies.forEach((bodie){
      Unit unit = new Unit(bodie.userData.id);
      unit.position = bodie.position;
      unit.size = bodie.userData.size;
      units.add(unit);
    });

    return new State(
      _stopwatch.elapsedMilliseconds / 1000,
      units
    );
  }

  void _getClock(Clock clock) {
    if(clock == null){
      _clock = new InfiniteClock(new Duration(milliseconds: 16));
    } else {
      _clock = clock;
    }
  }
}