import 'package:fitness_app/pages/auth/authcontroller.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: const Color.fromRGBO(20, 20, 20, 1),
      child: IconTheme(
        data: const IconThemeData(color: Color.fromRGBO(30, 215, 96, 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/dashboard');
            },
            child: const Icon(Icons.add_chart)),

          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/workoutDashboard');
            },
            child: const Icon(Icons.fitness_center)),

          Transform.translate(
            offset: const Offset(0, -15),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Container(
                padding: const EdgeInsets.all(13),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Color.fromRGBO(30, 215, 96, 1), 
                      Color.fromRGBO(30, 30, 30, 1)
                    ]
                  )
                  ),
                child: const Icon(Icons.home, color: Colors.white,),
              ),
            ),
          ),
          
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/tracker');
            },
            child: const Icon(Icons.gps_fixed)),
            
            GestureDetector(
              onTap: (() {
                AuthController.instance.signOut();
              }),
              child: const Icon(Icons.logout)),
        ],
        ),
      ),
    );
  }
}