import "dart:async";
import "package:test/test.dart";
import "package:syncball/sync_ball.dart";

void main() {

  test('it provides ticks', (){
    int count = 5;
    Clock clock = new Clock(count, new Duration(seconds: 0));
    Stream<double> stream = clock.onTick;
    stream.listen(expectAsync((delta) {
      expect(delta is double, true);
    }, count: count));
  });
}