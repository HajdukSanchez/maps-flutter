import 'package:flutter/material.dart';

class EndMarkerPainter extends CustomPainter {
  final String minutes;
  final String description;

  EndMarkerPainter({required this.minutes, required this.description});

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()..color = Colors.black; // Black pencil
    final whitePaint = Paint()..color = Colors.white; // White pencil
    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;
    // Black circle
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - circleBlackRadius), circleBlackRadius, blackPaint);
    // White circle
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - circleBlackRadius), circleWhiteRadius, whitePaint);
    // Paint white box
    final path = Path();
    path.moveTo(40, 20); // Move without drawing
    path.lineTo(size.width - 10, 20); // Draw line
    path.lineTo(size.width - 10, 100); // Draw line
    path.lineTo(40, 100); // Draw line

    canvas.drawShadow(path, Colors.black, 10, false); // Box shadow
    canvas.drawPath(path, whitePaint); // Paint white box using path

    // Paint black box
    const blackBox = Rect.fromLTWH(40, 20, 80, 80);
    canvas.drawRect(blackBox, blackPaint);

    // TEXTS
    // Minutes text
    final textSpanMinutes = TextSpan(
      text: minutes,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
    );
    final minutesPainter = TextPainter(
        text: textSpanMinutes, textDirection: TextDirection.ltr, textAlign: TextAlign.center)
      ..layout(minWidth: 70, maxWidth: 70);
    minutesPainter.paint(canvas, const Offset(45, 30));

    // MIN text
    const textSpanMIN = TextSpan(
      text: 'MIN',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w300,
      ),
    );
    final minPainter = TextPainter(
        text: textSpanMIN, textDirection: TextDirection.ltr, textAlign: TextAlign.center)
      ..layout(minWidth: 70, maxWidth: 70);
    minPainter.paint(canvas, const Offset(45, 65));

    // Description text
    final locationSpan = TextSpan(
      text: description,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w300,
      ),
    );
    final locationPainter = TextPainter(
        text: locationSpan,
        maxLines: 2,
        ellipsis: "...",
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left)
      ..layout(minWidth: size.width - 140, maxWidth: size.width - 140);

    final double locationOffsetY = description.length > 20 ? 35 : 48;

    locationPainter.paint(canvas, Offset(130, locationOffsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
