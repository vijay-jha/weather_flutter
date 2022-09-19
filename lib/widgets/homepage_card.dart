import 'package:flutter/material.dart';

class HomePageCard extends StatefulWidget {
  HomePageCard({
    required this.imageSrc,
    this.isWeather = false,
    this.textBelowIcon = "",
    this.value = "",
    this.cityName = "",
  });
  String cityName;
  String imageSrc;
  String value;
  String textBelowIcon;
  bool isWeather;

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: _deviceSize.height * 0.025,
              horizontal: _deviceSize.width * 0.07,
            ),
            height: _deviceSize.height * 0.2,
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
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            right: _deviceSize.width * 0.085,
            top: _deviceSize.height * 0.035,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              widget.imageSrc,
              height: _deviceSize.height * 0.13,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: _deviceSize.width * 0.14, top: _deviceSize.height * 0.088),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _deviceSize.width * 0.45,
                  child: RichText(
                    text: TextSpan(
                      text: widget.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: widget.textBelowIcon.isNotEmpty ? 50 : 16,
                      ),
                      children: [
                        if (widget.isWeather)
                          const TextSpan(
                            text: '°',
                          ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 35,
                // ),
                Text(
                  '${widget.cityName}, India',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
        if (widget.textBelowIcon.isNotEmpty)
          Container(
            width: _deviceSize.width * 0.28,
            margin: EdgeInsets.only(
              top: _deviceSize.height * 0.188,
              left: _deviceSize.width * 0.63,
            ),
            child: Text(
              widget.textBelowIcon,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
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
