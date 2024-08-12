import 'package:flutter/material.dart';

class Builder extends StatelessWidget {
  const Builder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text(
              '코스 만들기',
              style: TextStyle(fontSize: 15),
            ),
            Text('성수동 데이트', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
      body: Center(child: CustomSlider()),
    );
  }
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          painter: SliderPainter(_currentValue),
          child: SizedBox(
            height: 50,
            width: 300,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _currentValue =
                      (details.localPosition.dx / 300).clamp(0.0, 1.0);
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        Text('Value: ${(_currentValue * 100).round()}'),
      ],
    );
  }
}

class SliderPainter extends CustomPainter {
  final double value;

  SliderPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4;

    final activePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4;

    final circlePaint = Paint()..color = Colors.blue;

    // Draw the inactive track
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);

    // Draw the active track
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width * value, size.height / 2), activePaint);

    // Draw the circles
    for (int i = 0; i < 3; i++) {
      double dx = size.width * (i / 2);
      canvas.drawCircle(Offset(dx, size.height / 2), 10,
          i / 2 <= value ? circlePaint : paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
