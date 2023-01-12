import 'package:flutter/material.dart';

enum ProgramType {
  cardio,
  chest, 
  back, 
  legs, 
  shoulders, 
  arms
}

class FitnessProgram {
  final AssetImage image;
  final String name;
  final String cals;
  final String time;
  final ProgramType type;

  FitnessProgram({
    required this.image, 
    required this.name, 
    required this.cals, 
    required this.time,
    required this.type,
  });
}

final List<FitnessProgram> fitnessPrograms = [
  FitnessProgram(image: const AssetImage('assets/cardioProgramPic.jpg'), 
  name: 'Cardio', 
  cals: '220kcal', 
  time: '25 Mins',
  type: ProgramType.cardio
  ),
  
  FitnessProgram(image: const AssetImage('assets/chestProgramPic.jpg'), 
  name: 'Chest', 
  cals: '340kcal', 
  time: '45 Mins',
  type: ProgramType.chest
  ),

  FitnessProgram(image: const AssetImage('assets/backProgramPic.jpg'), 
  name: 'Back', 
  cals: '410kcal', 
  time: '55 Mins',
  type: ProgramType.back
  ),

  FitnessProgram(image: const AssetImage('assets/legsProgramPic.jpg'), 
  name: 'Legs', 
  cals: '520kcal', 
  time: '90 Mins',
  type: ProgramType.legs
  ),

  FitnessProgram(image: const AssetImage('assets/shoulderProgramPic.jpg'), 
  name: 'Shoulders', 
  cals: '420kcal', 
  time: '45 Mins',
  type: ProgramType.shoulders
  ),

  FitnessProgram(image: const AssetImage('assets/armsProgramPic.jpg'), 
  name: 'Arms', 
  cals: '180kcal', 
  time: '30 Mins',
  type: ProgramType.arms
  )
];