import "dart:async";
import "package:test/test.dart";
import "package:syncball/sync_ball.dart";

void main() {


PointServer server;

  setUp(() {
    Clock clock = new Clock(3, new Duration(seconds: 0));
    server = new PointServer(clock);
  });

  test('it provides x States from stream', () async {
    Stream<State> stream = server.onUpdate;

    stream.listen(expectAsync((state) {
      expect(state is State, true);
    }, count: 3));
  });
}
