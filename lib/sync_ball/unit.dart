part of sync_ball;

class Unit {
  Vector2 position = new Vector2.zero();
  Vector2 velocity = new Vector2.zero();
  double size = 1.0;
  int id;

  Unit(this.id);

  void update(double delta){
    position += velocity * delta;
  }

  String toString(){
    return {
      "position": position.toString()
    }.toString();
  }

  Map toJson() => {
    "id": id,
    "position": {"x": position.x, "y": position.y},
    "velocity": {"x": velocity.x, "y": velocity.y},
    "size": size
  };

  Unit.fromMap(Map map){
    id = map['id'];
    position = new Vector2(map['position']['x'], map['position']['y']);
    velocity = new Vector2(map['velocity']['x'], map['velocity']['y']);
    size = map['size'];
  }
}