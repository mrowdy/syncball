import "package:test/test.dart";
import "dart:async";
import "package:syncball/sync_ball.dart";

void main() {

  Game game;

  setUp((){
    game = new Game();
  });

  test('it implements Game', (){
    expect(game is Game, true);
  });

  group("State", () {
    test('it is stopped when created', (){
      expect(game.isRunning, false);
    });

    test('it can be started', (){
      game.start();
      expect(game.isRunning, true);
    });


    test('it is not running when it is stopped', (){
      game.start();
      game.stop();
      expect(game.isRunning, false);
    });

    test('it is possible to get the current state', (){
      expect(game.state is State, true);
    });

    test('its initial state is at time zero', (){
      expect(game.state.time, 0.0);
    });

    test('its initial state has the given amount of units', (){
      int count = 5;
      game = new Game(units: count);
      game.start();
      expect(game.state.units.length, count);
    });

    test('it has a new state when it gets stopped', (){
      State state1 = game.state;
      game.start();
      game.stop();
      State state2 = game.state;
      expect(state1 != state2, true);
    });

    test('its has update stream', (){
      expect(game.onUpdate is Stream<State>, true);
    });

    test('its accepts custom clock', (){
      game = new Game(clock: new LimitedClock(3, new Duration(milliseconds: 3)));
      expect(game.state.time, 0.0);
    });

    test('it is possible to create game from state', (){
      State state = new State(0.0, new List<Unit>());
      game = new Game.fromState(state);
      expect(game.state,state);
    });
  });

  group("Streaming", () {
    test('it does not update when game is not started', (){
      game = new Game(clock: new LimitedClock(3, new Duration(milliseconds: 3)));
      game.onUpdate.listen(expectAsync((_){}, count: 0));
    });

    test('it does not update when game is stopped', (){
      game = new Game(clock: new LimitedClock(3, new Duration(milliseconds: 3)));
      game.onUpdate.listen(expectAsync((_){}, count: 0));
      game.start();
      game.stop();
    });
  });
}