library client;

import "dart:html" hide Screen;
import "dart:async";
import "dart:math";

import "package:syncball/sync_ball.dart";

part "canvas_screen.dart";
part "frame_clock.dart";

void main(){
  CanvasElement canvas = querySelector("#game") as CanvasElement;

  Server server = new PointServer(new InfiniteClock(new Duration(milliseconds: 100)));
  Screen screen = new CanvasScreen(canvas, new FrameClock());


//  server.onUpdate.listen(screen.pushState);

  InterpolatedServer iServer = new InterpolatedServer(
      new InfiniteClock(new Duration(milliseconds: 16)), 1.0);
  server.onUpdate.listen(iServer.pushState);
  iServer.onUpdate.listen(screen.pushState);
}