import 'dart:async';

import 'package:amo_fly/amo.dart';
import 'package:flutter/material.dart';

import 'barriers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double amoYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;
  // setup barrier
  double barrierXOne = 0;
  double barrierXTwo = 1;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = amoYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      //********** this code to control character movement ******//
      time += 0.03;
      height = -4.9 * time * time + 3 * time;
      //********** this code to control character movement ******//
      debugPrint(height.toString());
      setState(() {
        amoYaxis = initialHeight - height;

        debugPrint('amoYaxis = ' + amoYaxis.toString());
      });

      setState(() {
        if (barrierXOne < -2.5) {
          barrierXOne += 4;
        } else {
          barrierXOne -= 0.05;
        }
      });
      setState(() {
        if (barrierXTwo < -2.5) {
          barrierXTwo += 4;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (amoYaxis > 1.1) {
        timer.cancel();
        gameHasStarted = false;
        //reset value to start game
        amoYaxis = 0;
        height = 0;
        initialHeight = 0;
        time = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              //split screen 3/4
              flex: 3,
              //use GestureDetector for get tap action from user
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, amoYaxis),
                    //need to add duration
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: const MyAmo(),
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
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarriers(
                      size: 100.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 12,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Name',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        const Text(
                          'Joey',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Score',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        const Text(
                          '10',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
