import 'package:fitness_app/models/food_tracker_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class CalorieStats extends StatelessWidget {
  DateTime datePicked;
  DateTime today = DateTime.now();
  CalorieStats({super.key, required this.datePicked});

  num totalCalories = 0;
  num totalCarbs = 0;
  num totalFat = 0;
  num totalProtein = 0;
  num displayCalories = 0;

  bool dateCheck() {
    DateTime formatPicked =
        DateTime(datePicked.year, datePicked.month, datePicked.day);
    DateTime formatToday = DateTime(today.year, today.month, today.day);
    if (formatPicked.compareTo(formatToday) == 0) {
      return true;
    } else {
      return false;
    }
  }

  static List<num> macroData = [];

  @override
  Widget build(BuildContext context) {
    final DateTime curDate =
        DateTime(datePicked.year, datePicked.month, datePicked.day);

    final foodTracks = Provider.of<List<FoodTrackTask>>(context);

    List findCurFoodTracks(List<FoodTrackTask> foodTracks) {
      List currentFoodTracks = [];
      for (var foodTrack in foodTracks) {
        DateTime trackDate = DateTime(foodTrack.createdOn.year,
            foodTrack.createdOn.month, foodTrack.createdOn.day);
        if (trackDate.compareTo(curDate) == 0) {
          currentFoodTracks.add(foodTrack);
        }
      }
      return currentFoodTracks;
    }

    List currentFoodTracks = findCurFoodTracks(foodTracks);

    void findNutriments(List foodTracks) {
      for (var foodTrack in foodTracks) {
        totalCarbs += foodTrack.carbs;
        totalFat += foodTrack.fat;
        totalProtein += foodTrack.protein;
        displayCalories += foodTrack.calories;
      }
      totalCalories = 9 * totalFat + 4 * totalCarbs + 4 * totalProtein;
    }

    findNutriments(currentFoodTracks);

    // ignore: deprecated_member_use
    List<PieChartSectionData> sections = <PieChartSectionData>[];

    PieChartSectionData fat = PieChartSectionData(
      color: const Color(0xFFE50914),
      value: ((totalFat) / totalCalories) * 100,
      title:
          '${((totalFat / totalCalories) * 100).toStringAsFixed(0)}%',
      radius: 50,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 24),
    );

    PieChartSectionData carbohydrates = PieChartSectionData(
      color: const Color(0xFF0E7AC7),
      value: ((4 * totalCarbs) / totalCalories) * 100,
      title:
          '${((4 * totalCarbs / totalCalories) * 100).toStringAsFixed(0)}%',
      radius: 50,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 24),
    );

    PieChartSectionData protein = PieChartSectionData(
      color: const Color(0xFF1DB954),
      value: ((4 * totalProtein) / totalCalories) * 100,
      title:
          '${((4 * totalProtein / totalCalories) * 100).toStringAsFixed(0)}%',
      radius: 50,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 24),
    );

    sections = [fat, protein, carbohydrates];

    macroData = [displayCalories, totalProtein, totalCarbs, totalFat];

    totalCarbs = 0;
    totalFat = 0;
    totalProtein = 0;
    displayCalories = 0;

    Widget _chartLabels() {
      return Padding(
        padding: const EdgeInsets.only(top: 78.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text('Carbs ',
                    style: TextStyle(
                      color: Color(0xFF0E7AC7),
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
                Text('${macroData[2].toStringAsFixed(1)}g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
            const SizedBox(height: 3.0),
            Row(
              children: <Widget>[
                const Text('Protein ',
                    style: TextStyle(
                      color: Color(0xFF1DB954),
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
                Text('${macroData[1].toStringAsFixed(1)}g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
            const SizedBox(height: 3.0),
            Row(
              children: <Widget>[
                const Text('Fat ',
                    style: TextStyle(
                      color: Color(0xFFE50914),
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
                Text('${macroData[3].toStringAsFixed(1)}g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ],
        ),
      );
    }

    Widget _calorieDisplay() {
      return Container(
        height: 74,
        width: 74,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(macroData[0].toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w500,
                )),
            const Text('kcal',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      );
    }

    if (currentFoodTracks.isEmpty) {
      if (dateCheck()) {
        return const Flexible(
          fit: FlexFit.loose,
          child: Text('You have not logged any food today.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w500,
                color: Colors.white
              )
          ),
        );
      } else {
        return const Flexible(
          fit: FlexFit.loose,
          child: Text('No food added on this day.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              )
          ),
        );
      }
    } else {
      return Container(
        color: const Color.fromRGBO(40, 40, 40, 1),
        width: MediaQuery.of(context).size.width,
        child: Row(
        children: <Widget>[
          Stack(alignment: Alignment.center, children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                  sectionsSpace: 3,
                ),
              ),
            ),
            _calorieDisplay(),
          ]),
          _chartLabels(),
        ],
        )
      );
    }
  }
}
