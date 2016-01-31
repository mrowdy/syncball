import "package:test/test.dart";
import "package:syncball/sync_ball.dart";

void main() {
  test('it has a time', (){
    State state = new State(0.0, new List<Unit>());
    expect(state.time is double, true);
  });

  test('it has units', (){
    State state = new State(0.0, new List<Unit>());
    expect(state.units is List<Unit>, true);
  });
}