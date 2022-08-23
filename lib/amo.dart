import 'package:flutter/material.dart';

class MyAmo extends StatelessWidget {
  const MyAmo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Image.asset('assets/amongus.png'),
    );
  }
}
