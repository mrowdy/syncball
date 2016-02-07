import "dart:html" hide Screen;
import "package:syncball/sync_ball.dart";
import "package:syncball/client.dart";
import 'dart:async';

void main(){
  Server server = createServer();

  createClient(server);

}

Server createServer() {
  Screen screen = new CanvasScreen(
      querySelector("#server"),
      new FrameClock()
  );

  Server server = new PointServer(new InfiniteClock(new Duration(milliseconds: 100)));
  server.onUpdate.listen(screen.pushState);
  return server;
}

Game createClient(Server server) {
  Screen screen = new CanvasScreen(
      querySelector("#client"),
      new FrameClock()
  );

  InterpolatedServer iServer = new InterpolatedServer(
      new InfiniteClock(new Duration(milliseconds: 16)),
      0.300
  );

  server.onUpdate.listen(iServer.pushState);
  iServer.onUpdate.listen(screen.pushState);
}