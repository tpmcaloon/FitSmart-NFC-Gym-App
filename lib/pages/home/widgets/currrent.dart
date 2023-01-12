import 'package:fitness_app/models/fitness_program.dart';
import 'package:flutter/material.dart';

class CurrentProgrammes extends StatefulWidget {
  const CurrentProgrammes({super.key});

  @override
  State<CurrentProgrammes> createState() => _CurrentProgrammesState();
}

class _CurrentProgrammesState extends State<CurrentProgrammes> {
  ProgramType active = fitnessPrograms[0].type;

  void _changeProgram(ProgramType newType) {
    setState(() {
      active = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:const Color.fromRGBO(25,20,20,1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Current Programmes", 
                style: Theme.of(context).textTheme.headline1),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Color.fromRGBO(30, 215, 96, 0.8),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 125,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              scrollDirection: Axis.horizontal,
              itemCount: fitnessPrograms.length,
              itemBuilder: (context, index) {
                return Program(
                  programs: fitnessPrograms[index],
                  active: fitnessPrograms[index].type == active,
                  onTap: _changeProgram,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            ),
          )
        ],
      ),
    );
  }
}

class Program extends StatelessWidget {
  final FitnessProgram programs;
  final bool active;
  final Function(ProgramType) onTap;

  const Program({super.key, required this.programs, this.active = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        onTap(programs.type);
      },
      child: Container(
        height: 125,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              active ? const Color.fromRGBO(30, 215, 96, 0.6) : const Color.fromRGBO(255, 255, 255, 0.75), 
              BlendMode.lighten
            ),
            image: programs.image,
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(15),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: active ? Colors.white : const Color.fromRGBO(20, 20, 20, 0.75),
            fontSize: 10,
            fontWeight: FontWeight.w500
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(programs.name, 
              style: TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.w900,
                color: active ? Colors.white:Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(programs.cals),
                  const SizedBox(width: 15),
                  Icon(Icons.timer, 
                  color: active ? Colors.white: Colors.black, 
                  size: 10,),
                  const SizedBox(width: 5),
                  Text(programs.time)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}