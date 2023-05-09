import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset pointA;
  final Offset pointB;

  LinePainter({required this.pointA, required this.pointB});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    canvas.drawLine(pointA, pointB, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LineScreen extends StatefulWidget {
  const LineScreen({super.key});

  @override
  _LineScreenState createState() => _LineScreenState();
}

class _LineScreenState extends State<LineScreen> {
  final GlobalKey _keyA = GlobalKey();
  final GlobalKey _keyB = GlobalKey();
  Offset? _pointA;
  Offset? _pointB;

  void _onTapA() {
    final RenderBox boxA =
        _keyA.currentContext!.findRenderObject() as RenderBox;
    final Offset positionA = boxA.localToGlobal(Offset.zero);
    setState(() {
      _pointA = positionA + Offset(boxA.size.width / 2, boxA.size.height / 2);
    });
  }

  void _onTapB() {
    final RenderBox boxB =
        _keyB.currentContext!.findRenderObject() as RenderBox;
    final Offset positionB = boxB.localToGlobal(Offset.zero);
    setState(() {
      _pointB = positionB + Offset(boxB.size.width / 2, boxB.size.height / 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw a Line'),
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: _pointA != null && _pointB != null
                ? LinePainter(pointA: _pointA!, pointB: _pointB!)
                : null,
            size: Size.infinite,
          ),
          Positioned(
            key: _keyA,
            left: 50,
            top: 50,
            child: GestureDetector(
              onTap: _onTapA,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            key: _keyB,
            right: 50,
            top: 50,
            child: GestureDetector(
              onTap: _onTapB,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
