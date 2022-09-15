import 'package:flutter/material.dart';
class FrameworkMain extends StatelessWidget {
  const FrameworkMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              width: double.infinity,
              height: 220,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 76,
                    left: 16,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 230,
                      height: 53,
                    ),
                  ),
                  Positioned(
                    top: 126,
                    left: 252,
                    right: 93,
                    child: Image.asset(
                      'assets/images/tronlon.png',
                    ),
                  ),
                  Positioned(
                    top: 151,
                    bottom: 42,
                    right: 46,
                    child: Image.asset(
                      'assets/images/tronnho.png',
                    ),
                  ),
                  Positioned(
                    top: 41,
                    right: 0,
                    bottom: 82,
                    child: Image.asset(
                      'assets/images/nuahinhtron.png',
                    ),
                  ),
                  const Positioned(
                    bottom: 50,
                    right: 24,
                    child: Text(
                      'Hotline phản hồi',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Color(0xffBCBCBC)),
                    ),
                  ),
                  const Positioned(
                    bottom: 30,
                    right: 24,
                    child: Text(
                      '0913 714 479',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          color: Colors.red),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: CustomPaint(
                      size: const Size(450, 230),
                      painter: CurvedPainter(),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: CustomPaint(
                      size: const Size(450, 230),
                      painter: CurvedPainter2(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color =const Color(0xffCCEFFF)
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.6,
        size.width * 0.45, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.7, size.height * 1.15,
        size.width * 1.25, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvedPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color =const Color(0xffE5E5E5)
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.6,
        size.width * 0.45, size.height * 0.87);
    path.quadraticBezierTo(size.width * 0.7, size.height * 1.18,
        size.width * 1.2, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}