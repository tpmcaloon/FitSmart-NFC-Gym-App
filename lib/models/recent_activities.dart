import 'package:flutter/material.dart';

class FitnessProgram {
  final AssetImage image;
  final String name;
  final String cals;
  final String time;

  FitnessProgram({
    required this.image, 
    required this.name, 
    required this.cals, 
    required this.time,
  });
}

final List<FitnessProgram> fitnessPrograms = [
  FitnessProgram(image: const AssetImage('assets/cardioProgramPic.jpg'), 
  name: 'Walk', 
  cals: '220kcal', 
  time: '25 Mins',
  ),
  
  FitnessProgram(image: const AssetImage('assets/chestProgramPic.jpg'), 
  name: 'Chest Workout', 
  cals: '340kcal', 
  time: '45 Mins',
  ),

  FitnessProgram(image: const AssetImage('assets/backProgramPic.jpg'), 
  name: 'Run', 
  cals: '410kcal', 
  time: '55 Mins',
  ),

  FitnessProgram(image: const AssetImage('assets/legsProgramPic.jpg'), 
  name: 'Swim', 
  cals: '520kcal', 
  time: '90 Mins',
  ),

  FitnessProgram(image: const AssetImage('assets/shoulderProgramPic.jpg'), 
  name: 'Walk', 
  cals: '420kcal', 
  time: '45 Mins',
  ),

  FitnessProgram(image: const AssetImage('assets/armsProgramPic.jpg'), 
  name: 'Back Workout', 
  cals: '180kcal', 
  time: '30 Mins',
  )
];