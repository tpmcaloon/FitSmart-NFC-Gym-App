
import 'package:fitness_app/pages/workoutDashboard/widgets/menu.dart';
import 'package:fitness_app/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/pages/workoutDashboard//widgets/appbar.dart';

class WorkoutDashboard extends StatelessWidget {
  const WorkoutDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      appBar: MainAppBar(appBar: AppBar()),
      body: Column(
        children: const[
          WorkoutDashboardMenu(),
          BottomNavigation()
        ],
      ),
    );
  }
}