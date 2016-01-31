library client;

import "dart:html" hide Screen;
import "dart:async";
import "dart:math";

import "package:syncball/sync_ball.dart";

part "canvas_screen.dart";
part "frame_clock.dart";

void main(){
  CanvasElement canvas = querySelector("#game") as CanvasElement;
  Clock renderClock = new FrameClock();
  Clock debounceClock = new InfiniteClock(new Duration(milliseconds: 16));

  Server server = new PointServer(new InfiniteClock(new Duration(milliseconds: 1000)));

  Screen screen = new CanvasScreen(canvas, renderClock);
  InterpolatedServer iServer = new InterpolatedServer(debounceClock);

  //server.onUpdate.listen(screen.pushState);

  server.onUpdate.listen(iServer.pushState);
  iServer.onUpdate.listen(screen.pushState);
}