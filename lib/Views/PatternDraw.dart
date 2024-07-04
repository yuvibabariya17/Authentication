import 'package:demo/Views/PatternDot.dart';
import 'package:flutter/material.dart';

typedef PatternEnteredCallback = void Function(List<Offset> pattern);

class PatternDrawWidget extends StatefulWidget {
  final PatternEnteredCallback onPatternEntered;

  const PatternDrawWidget({super.key, required this.onPatternEntered});

  @override
  _PatternDrawWidgetState createState() => _PatternDrawWidgetState();
}

class _PatternDrawWidgetState extends State<PatternDrawWidget> {
  List<PatternDot> dots = [];
  List<Offset> points = [];

  @override
  void initState() {
    super.initState();
    // Initialize dots in a grid or custom positions as needed
    initializeDots();
  }

  void initializeDots() {
    const double dotSpacing = 60.0; // Space between dots
    const double dotSize = 12.0; // Diameter of each dot

    // Example: Initialize dots in a 3x3 grid
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        double x = dotSpacing * j + dotSpacing / 2;
        double y = dotSpacing * i + dotSpacing / 2;
        dots.add(PatternDot(position: Offset(x, y)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          points.add(details.localPosition);
          // Check if user's touch point intersects with any dot
          for (PatternDot dot in dots) {
            if (!_isDotSelected(dot) &&
                _isTouchNearDot(dot, details.localPosition)) {
              dot.isSelected = true;
              points.add(dot.position);
            }
          }
        });
      },
      onPanEnd: (details) {
        // Pattern drawing completed
        List<Offset> pattern = points.toList();
        widget.onPatternEntered(pattern);
        // Reset selected dots
        setState(() {
          points.clear();
          for (var dot in dots) {
            dot.isSelected = false;
          }
        });
      },
      child: CustomPaint(
        painter: PatternPainter(dots: dots, points: points),
        size: Size.infinite,
      ),
    );
  }

  bool _isDotSelected(PatternDot dot) {
    return dot.isSelected;
  }

  bool _isTouchNearDot(PatternDot dot, Offset touchPosition) {
    double distance = (dot.position - touchPosition).distance;
    return distance < 20.0; // Adjust this value for touch sensitivity
  }
}

class PatternPainter extends CustomPainter {
  final List<PatternDot> dots;
  final List<Offset> points;

  PatternPainter({required this.dots, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    // Draw lines between selected dots based on points drawn
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    // Draw dots on canvas
    for (PatternDot dot in dots) {
      canvas.drawCircle(dot.position, 10.0, paint);
      if (dot.isSelected) {
        canvas.drawCircle(dot.position, 4.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
