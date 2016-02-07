import "package:syncball/sync_ball.dart";

main(List<String> args) {

  Clock clock = new InfiniteClock(new Duration(milliseconds: 1000));

  Game game = new Game(clock: clock);
  game.start();

  game.onUpdate.listen((state){
    print(state.time);
  });
}
