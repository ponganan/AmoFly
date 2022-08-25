import 'dart:async';

import 'package:amo_fly/amo.dart';
import 'package:amo_fly/tree.dart';
import 'package:flutter/material.dart';
//import 'package:lottie/lottie.dart';

import 'barriers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double amoYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = amoYaxis;
  double gravity = -4.9; // How strong Gravity is
  double velocity = 2.8; // How strong Jump is
  bool gameHasStarted = false;
  // setup barrier
  double amoWidth = 0.1;
  double amoHeight = 0.1;

  // barrier variable
  static List<double> barrierX = [2, 2 + 1.5, 5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    //[topHeight, bottomHeight]
    [0.6, 0.4],
    [0.4, 0.6],
    [0.6, 0.4],
  ];

  void jump() {
    setState(() {
      time = 0;
      initialHeight = amoYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      //********** this code to control character movement ******//
      height = gravity * time * time + velocity * time;
      //********** this code to control character movement ******//
      debugPrint(height.toString());
      setState(() {
        amoYaxis = initialHeight - height;
      });

      //  setState(() {
      //    if (barrierXOne < -2.5) {
      //      barrierXOne += 4;
      //    } else {
      //       barrierXOne -= 0.025;
      //   }
      //  });
      //  setState(() {
      //    if (barrierXTwo < -2.5) {
      //      barrierXTwo += 4;
      //    } else {
      //      barrierXTwo -= 0.025;
      //    }
      //  });

      if (amoIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      } else {
        //Keep time going
        moveMap();
        time += 0.02;
      }
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.015;
        debugPrint('barrierX[i] = ' + barrierX.toString());
      });

      if (barrierX[i] < -2.5) {
        barrierX[i] += 8;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      //reset value to start game

      amoYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = amoYaxis;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Center(
              child: Text('GAME OVER'),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.white,
                      child: Text(
                        'PLAY AGAIN',
                        style: TextStyle(
                          color: Colors.blue.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  bool amoIsDead() {
    //Check Amo on Screen if not dead
    //if hit over top or bottom of screen
    if (amoYaxis < -1.5 || amoYaxis > 1.3) {
      //timer.cancel();
      //gameHasStarted = false;
      //reset value to start game
      // amoYaxis = 0;
      // height = 0;
      // initialHeight = 0;
      // time = 0;
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= amoWidth &&
          barrierX[i] + barrierWidth >= -amoWidth &&
          (amoYaxis <= -1 + barrierHeight[i][0] ||
              amoYaxis + amoHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    //use GestureDetector for get tap action from user
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              //split screen 3/4
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    //   AnimatedContainer(
                    //     alignment: Alignment(0, amoYaxis),
                    //need to add duration
                    //     duration: const Duration(milliseconds: 0),
                    //     color: Colors.blue,
                    MyAmo(
                      amoYaxis = amoYaxis,
                      amoWidth = amoWidth,
                      amoHeight = amoHeight,
                    ),
                    MyBarriers(
                      barrierX: barrierX[0],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][0],
                      isThisBottomBarrier: false,
                    ),
                    MyBarriers(
                      barrierX: barrierX[0],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][1],
                      isThisBottomBarrier: true,
                    ),
                    MyBarriers(
                      barrierX: barrierX[1],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][0],
                      isThisBottomBarrier: false,
                    ),
                    AmoTree(
                      barrierX: barrierX[1],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][1],
                      isThisBottomBarrier: true,
                    ),
                    MyBarriers(
                      barrierX: barrierX[2],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[2][0],
                      isThisBottomBarrier: false,
                    ),
                    MyBarriers(
                      barrierX: barrierX[2],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[2][1],
                      isThisBottomBarrier: true,
                    ),

                    Container(
                      alignment: Alignment(0, -0.6),
                      //depend on Game Start or not if Start This Text will disable
                      //this mean
                      // if game has started will put Text '';
                      // otherwise game not start will put Text 'TAP   TO   PLAY'
                      child: gameHasStarted
                          ? const Text('')
                          : const Text(
                              'TAP   TO   PLAY',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.white),
                            ),
                    ),
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Joey',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                          const Text(
                            'Score : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 12,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                alignment: Alignment.topCenter,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 150,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
