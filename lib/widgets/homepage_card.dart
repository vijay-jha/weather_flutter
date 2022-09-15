import 'package:flutter/material.dart';

class HomePageCard extends StatefulWidget {
  HomePageCard({this.image_src, this.image_height = 100});
  final image_src;
  double image_height;

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 132, 192, 78),
                  Color.fromARGB(255, 37, 137, 67),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              // color: Colors.red,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 30, top: 30),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              widget.image_src,
              height: widget.image_height,
            ),
          ),
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path
      ..lineTo(0.0, size.height * 0.1)
      ..quadraticBezierTo(
        size.width * 0.03,
        size.height * 0,
        size.width * 0.07,
        size.height * 0.053,
      )
      ..lineTo(size.width * 0.86, size.height * 0.45)
      ..quadraticBezierTo(
        size.width * 0.92,
        size.height * 0.48,
        size.width * 0.94,
        size.height * 0.7,
      )
      ..lineTo(size.width * 1, size.height * 1)
      ..lineTo(size.width * 0.0, size.height * 1)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
