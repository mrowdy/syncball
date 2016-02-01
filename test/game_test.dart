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

    test('it is paused when created', (){
      expect(game.isPaused, true);
    });

    test('it can be started', (){
      game.start();
      expect(game.isRunning, true);
    });

    test('it is not paused after started', (){
      game.start();
      expect(game.isPaused, false);
    });

    test('it is not running when it is stopped', (){
      game.start();
      game.stop();
      expect(game.isRunning, false);
    });

    test('it is paused when it is stopped', (){
      game.start();
      game.stop();
      expect(game.isPaused, true);
    });

    test('it can be paused', (){
      game.start();
      game.pause();
      expect(game.isPaused, true);
    });

    test('it can be resumed', (){
      game.start();
      game.pause();
      game.resume();
      expect(game.isPaused, false);
    });

    test('it is not stopped on pause', (){
      game.start();
      game.pause();
      expect(game.isRunning, true);
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
      game = new Game(clock: new Clock(3, new Duration(milliseconds: 3)));
      expect(game.state.time, 0.0);
    });
  });

  group("Streaming", () {
    test('its uses clock for updateing when running', (){
      game = new Game(clock: new Clock(3, new Duration(milliseconds: 3)));
      game.onUpdate.listen(expectAsync((_){}, count: 3));
      game.start();
    });

    test('it does not update when game is not started', (){
      game = new Game(clock: new Clock(3, new Duration(milliseconds: 3)));
      game.onUpdate.listen(expectAsync((_){}, count: 0));
    });

    test('it does not update when game is paused', (){
      game = new Game(clock: new Clock(3, new Duration(milliseconds: 3)));
      game.onUpdate.listen(expectAsync((_){}, count: 0));
      game.start();
      game.pause();
    });

    test('it does update when game is resumed', (){
      game = new Game(clock: new Clock(3, new Duration(milliseconds: 3)));
      game.onUpdate.listen(expectAsync((_){}, count: 3));
      game.start();
      game.pause();
      game.resume();
    });

    test('it does not update when game is stopped', (){
      game = new Game(clock: new Clock(3, new Duration(milliseconds: 3)));
      game.onUpdate.listen(expectAsync((_){}, count: 0));
      game.start();
      game.stop();
    });
  });

  group('update', (){
    test('its state updates time when running', (){
      game = new Game(clock: new Clock(2, new Duration(milliseconds: 1000)));
      game.start();
      game.onUpdate.listen(expectAsync((state){
        expect(state.time, 1.0);
      }, count: 1));
    });
  });
}