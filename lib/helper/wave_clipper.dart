import 'package:flutter/material.dart';

class WaveClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - ((size.height / 100) * 10));

    var firstControlPoint =
        Offset(size.width / 4, size.height + ((size.height / 100) * 8));
    var firstEndPoint =
        Offset(size.width / 2.25, size.height - ((size.height / 100) * 8));
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width / 1.3, size.height - ((size.height / 100) * 30));
    var secondEndPoint =
        Offset(size.width, size.height - ((size.height / 100) * 10));
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class WaveClipperProductBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - ((size.height / 100) * 2));

    var firstControlPoint =
        Offset(size.width / 4, size.height + ((size.height / 100) * 2.4));
    var firstEndPoint =
        Offset(size.width / 2, size.height - ((size.height / 100) * 3));
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width / 1.3, size.height - ((size.height / 100) * 7));
    var secondEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
