import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: const [
              Text('Workour Stats',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.white
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.pie_chart_rounded,
              size: 15,
              color: Color.fromRGBO(30, 215, 96, 1),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              SizedBox(width: 30),
              InfoStat(
                icon: Icons.timer, 
                iconColor: Color.fromRGBO(30, 215, 96, 1), 
                iconBackground: Color.fromRGBO(50, 80, 50, 1), 
                time: '+5s', 
                label: 'Time', 
                value: '30:34'
              ),
              SizedBox(width: 15),
              InfoStat(
                icon: Icons.favorite_border_outlined, 
                iconColor: Color(0xffe11e6c), 
                iconBackground: Color.fromRGBO(80,50,50,1), 
                time: '+Intensity', 
                label: 'Heart Rate', 
                value: '157 bpm'
              ),
              SizedBox(width: 15),
              InfoStat(
                icon: Icons.bolt, 
                iconColor: Color(0xffd3b50f), 
                iconBackground: Color.fromRGBO(80, 80, 50, 1), 
                time: '+30kcal', 
                label: 'Energy', 
                value: '213kcal'
              ),
              SizedBox(width: 30),
            ],
          ),
        )
      ],
    );
  }
}

class InfoStat extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String time;
  final String label;
  final String value;

  const InfoStat({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.time,
    required this.label,
    required this.value,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 110,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(50, 50, 50, 1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromRGBO(50, 50, 50, 1)
        ),
        boxShadow: const [BoxShadow(
          color: Color.fromRGBO(30, 215, 96, 0.5),
          offset: Offset(2,2),
          blurRadius: 3
        )]
      ),
      child: Stack(
        children: [
          StatIcon(
            icon: icon, 
            iconColor: iconColor, 
            iconBackground: iconBackground
          ),
          Change(time: time),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, 
                  style: const TextStyle(
                    fontSize: 10, 
                    color: Colors.white
                  ),
                ),
                Text(value,
                  style: const TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w800, 
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Change extends StatelessWidget {
  const Change({
    Key? key,
    required this.time,
  }) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 1, 
          horizontal: 4
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(500)
        ),
        child: Text(
          time, 
          style: const TextStyle(fontSize: 10, color: Colors.white),)
      ),
    );
  }
}

class StatIcon extends StatelessWidget {
  const StatIcon({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: iconBackground,
        borderRadius: BorderRadius.circular(9)
      ),
      child: Icon(icon, size: 15, color: iconColor),
    );
  }
}