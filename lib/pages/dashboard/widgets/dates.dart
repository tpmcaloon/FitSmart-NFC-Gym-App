import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dates extends StatelessWidget {
  const Dates({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateBox> dateBoxes = [];

    DateTime date = DateTime.now();
    String day = DateFormat('EEE').format(date); /// e.g Thursday

    for (int i = 0; i < 7; i++){
      dateBoxes.add(DateBox(date: date, day: day, active: i == 0));
      date = date.add(const Duration(days: 1));
      day = DateFormat('EEE').format(date.add(const Duration(days: 0))); /// e.g Thursday
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(25, 20, 20, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: dateBoxes,
        ),
      ),
    );
  }
}

class DateBox extends StatelessWidget {

  final bool active;
  final DateTime date;
  final String day;

  const DateBox({
    Key? key,
    this.active = false,
    required this.date,
    required this.day
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        gradient: active 
            ? const LinearGradient(colors: [
                Color.fromRGBO(30, 215, 96, 1), 
                Color.fromRGBO(25, 20, 20, 1)
              ], begin: Alignment.topCenter)
            : null,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromRGBO(30, 215, 96, 0.25)
        )
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          color: Colors.white),
        child: Column(
          children: [
            Text(day, 
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(date.day.toString(), 
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}