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
                onPressed: () {
                  Navigator.pushNamed(context, '/tag_read');
                  },
                child: const Text('Start Workout'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/workoutlog');
                  },
                child: const Text('View Past Workouts'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/thirdPage');
                  },
                child: const Text('Third Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
