import "dart:html" hide Screen;
import "package:syncball/sync_ball.dart";
import "package:syncball/client.dart";
import 'dart:async';

void main(){
  Server server = createServer();

  new Timer(new Duration(seconds: 3), () {
    createClient(server);
  });
}

Server createServer() {
  Screen screen = new CanvasScreen(
      querySelector("#server"),
      new FrameClock()
  );

  Server server = new PointServer(new InfiniteClock(new Duration(milliseconds: 16)));
  server.onUpdate.listen(screen.pushState);

  return server;
}

void createClient(Server server) {
  Screen screen = new CanvasScreen(
      querySelector("#client"),
      new FrameClock()
  );

  Game game = new Game.fromState(server.state);
  game.onUpdate.listen(screen.pushState);
  game.start();
}