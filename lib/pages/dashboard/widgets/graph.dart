import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SizedBox(
        width: double.infinity,
        child: GraphArea(),
      ),
    );
  }
}

class GraphArea extends StatefulWidget {
  const GraphArea({super.key});

  @override
  State<GraphArea> createState() => _GraphAreaState();
}

class _GraphAreaState extends State<GraphArea> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  List<DataPoint> data = [
    DataPoint(day: 1, steps: Random().nextInt(100)),
    DataPoint(day: 2, steps: Random().nextInt(100)),
    DataPoint(day: 3, steps: Random().nextInt(100)),
    DataPoint(day: 4, steps: Random().nextInt(100)),
    DataPoint(day: 5, steps: Random().nextInt(100)),
    DataPoint(day: 6, steps: Random().nextInt(100)),
    DataPoint(day: 7, steps: Random().nextInt(100)),
  ];

@override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2500));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GraphPainter(_animationController.view, data: data),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<DataPoint> data;
  final Animation<double> _size;
  final Animation<double> _dotSize;

  GraphPainter(Animation<double> animation, {required this.data})
      : _size = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation, 
            curve: const Interval(0.0, 0.5, curve: Curves.easeInOutCubicEmphasized)
          ),
        ),
        _dotSize = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation, 
            curve: const Interval(0.5, 1, curve: Curves.easeInOutCubicEmphasized)
          ),
        ),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {

        Paint backGColor = Paint()..color = const Color.fromRGBO(25, 20, 20, 1);
    canvas.drawRect(Rect.fromPoints(const Offset(0,0), Offset(size.width, size.height)), backGColor);

    var xSpacing = size.width / (data.length - 1);

    var maxSteps = data
        .fold<DataPoint>(data[0], (previous, current) => previous.steps > current.steps ? previous : current)
        .steps;

    var yRatio = size.height / maxSteps;
    var curveOffset = xSpacing * 0.3;

    List<Offset> offsets = [];

    var cx = 0.0;
    for(int i = 0; i < data.length; i++) {
      var y = size.height - (data[i].steps * yRatio * _size.value);

      offsets.add(Offset(cx, y));
      cx += xSpacing;
    }

    Paint lineColor = Paint()
        ..color = const Color.fromRGBO(30, 215, 96, 1)
        ..style =PaintingStyle.stroke
        ..strokeWidth = 3.0;

    Paint lineShadowColor = Paint()
            ..color = const Color.fromRGBO(25, 20, 20, 0.75)
            ..style =PaintingStyle.stroke
            ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.solid, 3)
            ..strokeWidth = 3.0;

    Paint fillPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, 0), 
        Offset(size.width / 2, size.height),
        [
          const Color.fromRGBO(30, 215, 96, 1), 
          const Color.fromRGBO(25, 20, 20, 1)
        ],
      )
      ..color = const Color.fromRGBO(30, 215, 96, 1)
      ..style =PaintingStyle.fill;

    Paint dotOutlinePaint = Paint()
        ..color = const Color.fromRGBO(255, 255, 255, 0.85)
        ..strokeWidth = 9;
    Paint dotCenter = Paint()
      ..color = const Color.fromRGBO(30, 215, 96, 1);

    Path linePath = Path();

    Offset currentOffset = offsets[0];

    linePath.lineTo(currentOffset.dx, currentOffset.dy);

    for (int i = 1; i < offsets.length; i++) {
      var x = offsets[i].dx;
      var y = offsets[i].dy;
      var c1x = currentOffset.dx + curveOffset;
      var c1y = currentOffset.dy;
      var c2x = x - curveOffset;
      var c2y = y;

      linePath.cubicTo(c1x, c1y, c2x, c2y, x, y);
      currentOffset = offsets[i];
    }

    Path fillPath = Path.from(linePath);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, lineShadowColor);
    canvas.drawPath(linePath, lineColor);

    canvas.drawCircle(offsets[4], 12.5 * _dotSize.value, dotOutlinePaint);
    canvas.drawCircle(offsets[4], 7.5 * _dotSize.value, dotCenter);
  }
  
  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return data != oldDelegate.data;
  }
}

class DataPoint {
  final int day;
  final int steps;

  DataPoint({
    required this.day,
    required this.steps
  });
}