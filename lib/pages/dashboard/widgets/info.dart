import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const[
        Stats(value: '345', unit: 'Kcal', label: 'Calories'),
        Stats(value: '9.3', unit: 'Km', label: 'Distance'),
        Stats(value: '1.2', unit: 'hr', label: 'Hours'),
      ],
    );
  }
}

class Stats extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const Stats({required this.value, required this.unit, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white
            ),
            children: [
              const TextSpan(text: ' '),
              TextSpan(
                text: unit,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            ]
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
        ),
      ],
    );
  }
}