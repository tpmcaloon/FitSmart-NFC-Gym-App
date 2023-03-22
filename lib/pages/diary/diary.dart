import 'package:fitness_app/pages/diary/widgets/calorie-stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness_app/models/food_tracker_task.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/db/firestore_db.dart';
import 'dart:math';
import '../../widgets/bottomnavigation.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DiaryState();
  }
}

class _DiaryState extends State<DiaryScreen> {
  String title = 'Add Food';
  double servingSize = 0;
  String dropdownValue = 'grams';
  DateTime _value = DateTime.now();
  DateTime today = DateTime.now();
  final _addFoodKey = GlobalKey<FormState>();

  DatabaseService databaseService =
  DatabaseService(uid: 'fitsmart-418db', currentDate: DateTime.now());

  late FoodTrackTask addFoodTrack;

  @override
  void initState() {
    super.initState();
    addFoodTrack = FoodTrackTask(
        food_name: "",
        calories: 0,
        carbs: 0,
        protein: 0,
        fat: 0,
        mealTime: "",
        createdOn: _value,
        grams: 0);
    databaseService.getFoodTrackData('fitsmart-418db');
  }

  void resetFoodTrack() {
    addFoodTrack = FoodTrackTask(
        food_name: "",
        calories: 0,
        carbs: 0,
        protein: 0,
        fat: 0,
        mealTime: "",
        createdOn: _value,
        grams: 0);
  }

  Widget _calorieCounter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height/3,
        child: Row(
          children: <Widget>[
            CalorieStats(datePicked: _value),
          ],
        ),
      ),
    );
  }

  Widget _addFoodButton() {
    return IconButton(
      key: const Key('add_food_modal_button'),
      icon: const Icon(Icons.add_box),
      iconSize: 25,
      color: const Color.fromRGBO(30, 215, 96, 1),
      onPressed: () async {
        setState(() {});
        _showFoodToAdd(context);
      },
    );
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _value,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xff5FA55A), //Head background
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _value = picked);
    _stateSetter();
  }

  void _stateSetter() {
    if (today.difference(_value).compareTo(const Duration(days: 1)) == -1) {
    } else {
    }
  }

  checkFormValid() {
    if (addFoodTrack.calories != 0 &&
        addFoodTrack.carbs != 0 &&
        addFoodTrack.protein != 0 &&
        addFoodTrack.fat != 0 &&
        addFoodTrack.grams != 0) {
      return true;
    }
    return false;
  }

  _showFoodToAdd(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: _showAmountHad(),
            key: const Key("add_food_modal"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1DB954),
                ),
                onPressed: () async {
                  if (checkFormValid()) {
                    Navigator.pop(context);
                    var random = Random();
                    int randomMilliSecond = random.nextInt(1000);
                    addFoodTrack.createdOn = _value;
                    addFoodTrack.createdOn = addFoodTrack.createdOn
                        .add(Duration(milliseconds: randomMilliSecond));
                    databaseService.addFoodTrackEntry(addFoodTrack);
                    resetFoodTrack();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Invalid form data! All numeric fields must contain numeric values greater than 0"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: const Text('Add Food', key: Key("add_food_modal_submit")),
              ),
            ],
          );
        });
  }

  Widget _showAmountHad() {
    return Scaffold(
      body: Column(children: <Widget>[
        _showAddFoodForm(),
        _showUserAmount(),
      ]),
    );
  }

  Widget _showAddFoodForm() {
    return Form(
      key: _addFoodKey,
      child: Column(children: [
        TextFormField(
          style: const TextStyle(color: Colors.white),
          key: const Key('add_food_modal_food_name_field'),
          decoration: const InputDecoration(
            labelText: "Food Name", labelStyle: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w900),
            hintText: "Enter food name", hintStyle: TextStyle(color: Colors.white),
            focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5)
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter the food name";
            }
            return null;
          },
          onChanged: (value) {
            addFoodTrack.food_name = value;
          },
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          key: const Key('add_food_modal_calorie_field'),
          decoration: const InputDecoration(
            labelText: "Calories", labelStyle: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w900),
            hintText: "Enter calorie amount", hintStyle: TextStyle(color: Colors.white),
            focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5)
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a calorie amount";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              addFoodTrack.calories = int.parse(value);
            } catch (e) {
              // return "Please enter numeric values"
              addFoodTrack.calories = 0;
            }

            // addFood.calories = value;
          },
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          key: const Key('add_food_modal_carbs_field'),
          decoration: const InputDecoration(
            labelText: "Carbs", labelStyle: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w900),
            hintText: "Enter carbs amount", hintStyle: TextStyle(color: Colors.white),
            focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5)
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a carbs amount";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              addFoodTrack.carbs = int.parse(value);
            } catch (e) {
              addFoodTrack.carbs = 0;
            }
          },
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          key: const Key('add_food_modal_protein_field'),
          decoration: const InputDecoration(
            labelText: "Protein", labelStyle: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w900),
            hintText: "Enter protein amount", hintStyle: TextStyle(color: Colors.white),
            focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5)
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a protein amount";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              addFoodTrack.protein = int.parse(value);
            } catch (e) {
              addFoodTrack.protein = 0;
            }
          },
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          key: const Key('add_food_modal_fat_field'),
          decoration: const InputDecoration(
            labelText: "Fat", labelStyle: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w900),
            hintText: "Enter fat amount", hintStyle: TextStyle(color: Colors.white),
            focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5)
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a fat amount";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              addFoodTrack.fat = int.parse(value);
            } catch (e) {
              addFoodTrack.fat = 0;
            }
          },
        ),
      ]),
    );
  }

  Widget _showUserAmount() {
    return Expanded(
      child: TextField(
          style: const TextStyle(color: Colors.white),
          key: const Key("add_food_modal_grams_field"),
          maxLines: 1,
          decoration: const InputDecoration(
            labelText: "Grams", labelStyle: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w900),
            hintText: "eg. 100g", hintStyle: TextStyle(color: Colors.white),
            focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5)
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            try {
              addFoodTrack.grams = int.parse(value);
            } catch (e) {
              addFoodTrack.grams = 0;
            }
            setState(() {
              servingSize = double.tryParse(value) ?? 0;
            });
          }),
    );
  }

  Widget _showDatePicker() {
    return SizedBox(
      width: 250,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            key: const Key("left_arrow_button"),
            icon: const Icon(Icons.arrow_left, size: 25.0),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _value = _value.subtract(const Duration(days: 1));
              });
            },
          ),
          TextButton(
            onPressed: () => _selectDate(),
            child: Text(_dateFormatter(_value),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Open Sans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          IconButton(
              key: const Key("right_arrow_button"),
              icon: const Icon(Icons.arrow_right, size: 25.0),
              color: Colors.white,
              onPressed: () {
                if (today.difference(_value).compareTo(const Duration(days: 1)) ==
                    -1) {
                  setState(() {
                  });
                } else {
                  setState(() {
                    _value = _value.add(const Duration(days: 1));
                  });
                  if (today.difference(_value).compareTo(const Duration(days: 1)) ==
                      -1) {
                    setState(() {
                    });
                  }
                }
              }),
        ],
      ),
    );
  }

  String _dateFormatter(DateTime tm) {
    DateTime today = DateTime.now();
    Duration oneDay = const Duration(days: 1);
    Duration twoDay = const Duration(days: 2);
    String month;

    switch (tm.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
      default:
        month = "Undefined";
        break;
    }

    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      return "Today";
    } else if (difference.compareTo(twoDay) < 1) {
      return "Yesterday";
    } else {
      return "${tm.day} $month ${tm.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width/6,
                  ),
                  _showDatePicker(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/10,
                  ),
                  _addFoodButton(),
                ],
              ),
            )),
        body: StreamProvider<List<FoodTrackTask>>.value(
          initialData: const [],
          value: DatabaseService(
              uid: "fitsmart-418db", currentDate: DateTime.now())
              .foodTracks,
          child: Column(children: <Widget>[
            _calorieCounter(),
            Expanded(
                key: const Key("food_track_list"),
                child: ListView(
                  children: <Widget>[FoodTrackList(datePicked: _value)],
                )
            ),
            const BottomNavigation(),
          ]
          ),
        )
    );
  }
}

class FoodTrackList extends StatelessWidget {
  final DateTime datePicked;
  late List<dynamic> curFoodTracks;
  late DatabaseService databaseService;
  FoodTrackList({super.key, required this.datePicked});

  @override
  Widget build(BuildContext context) {
    final DateTime curDate =
    DateTime(datePicked.year, datePicked.month, datePicked.day);

    final foodTracks = Provider.of<List<FoodTrackTask>>(context);

    List findCurFoodTracks(List foodTrackFeed) {
      List curFoodTracks = [];
      for (var foodTrack in foodTrackFeed) {
        DateTime createdDate = DateTime(foodTrack.createdOn.year,
            foodTrack.createdOn.month, foodTrack.createdOn.day);
        if (createdDate.compareTo(curDate) == 0) {
          curFoodTracks.add(foodTrack);
        }
      }
      return curFoodTracks;
    }

    curFoodTracks = findCurFoodTracks(foodTracks);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: curFoodTracks.length + 1,
      itemBuilder: (context, index) {
        if (index < curFoodTracks.length) {
          return FoodTrackTile(
              foodTrackEntry: curFoodTracks[index], keyValue: index);
        } else {
          return const SizedBox(height: 5);
        }
      },
    );
  }

  Future<void> loadFromMockDatabase() async {
    databaseService = DatabaseService(
        uid: "fitsmart-418db", currentDate: DateTime.now());
    curFoodTracks.add(await databaseService.loadFoodTrackEntryToDatabase());
  }
}

class FoodTrackTile extends StatelessWidget {
  final FoodTrackTask foodTrackEntry;
  DatabaseService databaseService = DatabaseService(
      uid: "fitsmart-418db", currentDate: DateTime.now()
  );
  int keyValue;

  FoodTrackTile({super.key, required this.foodTrackEntry, required this.keyValue});

  List macros = CalorieStats.macroData;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: Key("food_track_tile_$keyValue"),
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: const Color(0xff1DB954),
        child: _itemCalories(),
      ),
      title: Text(foodTrackEntry.food_name,
          style: const TextStyle(
            fontSize: 16.0,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w500,
            color: Colors.white
          )),
      subtitle: _macroData(),
      children: <Widget>[
        _expandedView(context),
      ],
    );
  }

  Widget _itemCalories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(foodTrackEntry.calories.toStringAsFixed(0),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w500,
            ),
        ),
        const Text('kcal',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w500,
            ),
        ),
      ],
    );
  }

  Widget _macroData() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0E7AC7),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(' ${foodTrackEntry.carbs.toStringAsFixed(1)}g    ',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1DB954),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                      ' ${foodTrackEntry.protein.toStringAsFixed(1)}g    ',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE50914),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(' ${foodTrackEntry.fat.toStringAsFixed(1)}g',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              Text('${foodTrackEntry.grams}g',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _expandedView(BuildContext context) {
    return Container(
        color: Color.fromRGBO(25, 20, 20, 1),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          expandedHeader(context),
          _expandedCalories(),
          _expandedCarbs(),
          _expandedProtein(),
          _expandedFat(),
        ],
      ),
    )
    );
  }

  Widget expandedHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('% of total',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
            ),
        ),
        IconButton(
            key: const Key("delete_button"),
            icon: const Icon(Icons.delete),
            iconSize: 16,
            color: Colors.white,
            onPressed: () async {
              databaseService.deleteFoodTrackEntry(foodTrackEntry);
            }),
      ],
    );
  }

  Widget _expandedCalories() {
    double caloriesValue = 0;
    if (!(foodTrackEntry.calories / macros[0]).isNaN) {
      caloriesValue = foodTrackEntry.calories / macros[0];
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 10.0,
            width: 200.0,
            child: LinearProgressIndicator(
              value: caloriesValue,
              backgroundColor: const Color(0xffEDEDED),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffFFB900)),
            ),
          ),
          Text('  Grams:  ${((caloriesValue) * 100).toStringAsFixed(0)}%',
            style: const TextStyle( color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _expandedCarbs() {
    double carbsValue = 0;
    if (!(foodTrackEntry.carbs / macros[2]).isNaN) {
      carbsValue = foodTrackEntry.carbs / macros[2];
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 10.0,
            width: 200.0,
            child: LinearProgressIndicator(
              value: carbsValue,
              backgroundColor: const Color(0xffEDEDED),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0E7AC7)),
            ),
          ),
          Text('  Carbs:  ${((carbsValue) * 100).toStringAsFixed(0)}%',
            style: const TextStyle( color: Colors.white)
          ),
        ],
      ),
    );
  }

  Widget _expandedProtein() {
    double proteinValue = 0;
    if (!(foodTrackEntry.protein / macros[1]).isNaN) {
      proteinValue = foodTrackEntry.protein / macros[1];
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 10.0,
            width: 200.0,
            child: LinearProgressIndicator(
              value: proteinValue,
              backgroundColor: const Color(0xffEDEDED),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1DB954)),
            ),
          ),
          Text('  Protein:   ${((proteinValue) * 100).toStringAsFixed(0)}%',
            style: const TextStyle( color: Colors.white)
          ),
        ],
      ),
    );
  }

  Widget _expandedFat() {
    double fatValue = 0;
    if (!(foodTrackEntry.fat / macros[3]).isNaN) {
      fatValue = foodTrackEntry.fat / macros[3];
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 10.0,
            width: 200.0,
            child: LinearProgressIndicator(
              value: (foodTrackEntry.fat / macros[3]),
              backgroundColor: const Color(0xffEDEDED),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE50914)),
            ),
          ),
          Text('  Fat:  ${((fatValue) * 100).toStringAsFixed(0)}%',
            style: const TextStyle( color: Colors.white)
          ),
        ],
      ),
    );
  }
}