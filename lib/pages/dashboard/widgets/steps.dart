import 'package:flutter/material.dart';

class Steps extends StatelessWidget {
  const Steps({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color:Color.fromRGBO(25, 20, 20, 1),
      ),
      child: Column(
        children: const[
          Text('12,321', 
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 2
            ),
          ),
          Text('Total Steps', 
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.5
            ),
          ),
        ],
      ),
    );
  }
}