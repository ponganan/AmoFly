import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AmoTree extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarrier;

  AmoTree({
    this.barrierWidth,
    this.barrierHeight,
    this.barrierX,
    required this.isThisBottomBarrier,
  });

  @override
  Widget build(BuildContext context) {
    // double xx;
    return Container(
      alignment: Alignment(
        (2 * barrierX + barrierWidth) / (2 - barrierWidth),
        isThisBottomBarrier ? 1 : -1,
      ),
      child: Container(
          color: Colors.white,
          child: Lottie.asset('assets/christmastree.json'),
          // width: MediaQuery.of(context).size.width * barrierWidth / 2,
          //height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
          width: MediaQuery.of(context).size.width * barrierWidth / 2,
          height: MediaQuery.of(context).size.height * 1 * barrierHeight / 2
          //xx = MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
          ),
    );
  }
}
