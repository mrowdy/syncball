import "package:test/test.dart";
import "package:syncball/sync_ball.dart";

void main() {

  test('it accepts states', (){
    Screen screen = new Screen();
    screen.pushState(new State(0.0, null));
  });
}