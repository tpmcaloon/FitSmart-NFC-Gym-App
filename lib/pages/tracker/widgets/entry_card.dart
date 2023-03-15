import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness_app/models/tracker_entry.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;
  const EntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(25, 20, 20, 1),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromRGBO(30, 215, 96, 1),
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(10),
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.date, style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white)),
                  Text("${(entry.distance / 1000).toStringAsFixed(2)} km",
                      style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(entry.duration,
                      style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white)),
                  Text("${entry.speed.toStringAsFixed(2)} km/h",
                      style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white)),
                ],
              ),
            ],
          )),
    );
  }
}