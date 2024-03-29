import 'package:fitness_app/pages/workoutLog/widgets/workoutList.dart';
import 'package:fitness_app/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/pages/workoutLog/widgets/appbar.dart';

class LogWorkoutPage extends StatelessWidget {
  const LogWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      appBar: MainAppBar(appBar: AppBar()),
      body: Column(
        children: const[
          ViewWorkoutPage(),
          BottomNavigation()
        ],
      ),
    );
  }
}