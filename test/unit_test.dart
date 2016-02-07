import "package:test/test.dart";
import "package:syncball/sync_ball.dart";
import 'package:vector_math/vector_math.dart';

void main() {

  Unit unit;

  setUp((){
    unit = new Unit(1);
  });

  test('it has an identifier', (){
    expect(unit.id is int, true);
  });

  test('it has a vector position', (){
    expect(unit.position is Vector2, true);
  });

  test('it has a size', (){
    expect(unit.size is double, true);
  });

  test('it has a velocity', (){
    expect(unit.velocity is Vector2, true);
  });

  test('it can be updated width delta time', (){
    unit.update(1.0);
  });
}