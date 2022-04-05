import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {
  final String description;

  StartMarkerPainter({required this.description});

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()..color = Colors.black; // Black pencil
    final whitePaint = Paint()..color = Colors.white; // White pencil

    // Black Reactangle
    canvas.drawRect(Rect.fromLTWH(size.width - 40, size.height - 40, 40, 40), blackPaint);
    // White Rectangle
    canvas.drawRect(Rect.fromLTWH(size.width - 27, size.height - 27, 15, 15), whitePaint);

    // Paint white box
    final path = Path();
    path.moveTo(20, 20); // Move without drawing
    path.lineTo(size.width - 40, 20); // Draw line
    path.lineTo(size.width - 40, 100); // Draw line
    path.lineTo(20, 100); // Draw line

    canvas.drawShadow(path, Colors.black, 10, false); // Box shadow
    canvas.drawPath(path, whitePaint); // Paint white box using path

    // TEXTS
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
        textAlign: TextAlign.center)
      ..layout(minWidth: size.width - 90, maxWidth: size.width - 90);

    final double locationOffsetY = description.length > 20 ? 35 : 48;

    locationPainter.paint(canvas, Offset(30, locationOffsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
