library client;

import "dart:html" hide Screen;
import "dart:async";
import "dart:math";

import "package:syncball/sync_ball.dart";

part "canvas_screen.dart";
part "frame_clock.dart";

void main(){

  CanvasElement canvas = querySelector("#game") as CanvasElement;

  Server server = new PointServer(new InfiniteClock(new Duration(milliseconds: 16)));
  Screen screen = new CanvasScreen(canvas, new FrameClock());

//  InterpolatedServer iServer = new InterpolatedServer(
//      new InfiniteClock(new Duration(milliseconds: 16)),
//      new Duration(seconds: 5)
//  );

  server.onUpdate.listen(screen.pushState);

//  server.onUpdate.listen(iServer.pushState);
//  iServer.onUpdate.listen(screen.pushState);
}