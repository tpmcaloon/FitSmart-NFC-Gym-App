import 'package:flutter/material.dart';

class WorkoutDashboardMenu extends StatelessWidget {
  const WorkoutDashboardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/tag_read');
                  },
                child: const Text('Start Workout'),
              ),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
              ),
                onPressed: () {
                Navigator.pushNamed(context, '/workoutlog');
                },
                child: const Text('View Past Workouts'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
