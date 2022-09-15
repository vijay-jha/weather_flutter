import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        height: 150,
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
      ..lineTo(size.width * 1, size.height * 0.55)
      // ..quadraticBezierTo(
      //   size.width * 0.85,
      //   size.height * 0.15,
      //   size.width * 0.93,
      //   size.height * 0.4,
      // )
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
