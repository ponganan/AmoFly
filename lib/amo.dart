import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyAmo extends StatelessWidget {
  final amoYaxis;
  final double amoWidth;
  final double amoHeight;

  MyAmo(
    this.amoYaxis,
    this.amoWidth,
    this.amoHeight,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * amoYaxis + amoHeight) / (2 - amoHeight)),
      child: Lottie.asset(
        'assets/flyingbee.json',
        //get width of flyingbee from real screen size for use to calulate when hit barriers
        width: MediaQuery.of(context).size.height * amoWidth / 1,
        //get height of flyingbee from real screen size for use to calulate when hit barriers
        height: MediaQuery.of(context).size.height * amoHeight / 1,
        fit: BoxFit.fill,
      ),
    );
  }
}
