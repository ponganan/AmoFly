import 'dart:async';

import 'package:amo_fly/amo.dart';
import 'package:flutter/material.dart';

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
      if (amoYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            //split screen 3/4
            flex: 3,
            //use GestureDetector for get tap action from user
            child: GestureDetector(
              onTap: () {
                if (gameHasStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              //use AnimatedContainer to build screen for character movement
              child: AnimatedContainer(
                alignment: Alignment(0, amoYaxis),
                //need to add duration
                duration: const Duration(milliseconds: 0),
                color: Colors.blue,
                child: const MyAmo(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
