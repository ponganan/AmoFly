import 'package:flutter/material.dart';

class MyBarriers extends StatelessWidget {
  final size;
  const MyBarriers({this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 10, color: Colors.green.shade800),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
