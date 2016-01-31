import "dart:async";
import "package:test/test.dart";
import "package:syncball/sync_ball.dart";

void main() {
  test('it provides a State stream', (){
    Server server = new Server();
    Stream<State> stream = server.onUpdate;
  });
}