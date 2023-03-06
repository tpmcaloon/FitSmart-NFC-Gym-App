import 'package:flutter/material.dart';
import 'package:fitness_app/pages/tracker/widgets/map.dart';
import 'package:fitness_app/models/entry.dart';
import 'package:fitness_app/pages/tracker/widgets/entry_card.dart';
import 'package:fitness_app/db/db.dart';
import 'package:fitness_app/pages/tracker/widgets/appbar.dart';
import '../../widgets/bottomnavigation.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({Key? key}) : super(key: key);

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  late List<Entry> _data;
  List<EntryCard> _cards = [];

  @override
  void initState() {
    super.initState();
    DB.init().then((value) => _fetchEntries());
  }

  void _fetchEntries() async {
    _cards = [];
    List<Map<String, dynamic>>? results = await DB.query(Entry.table);
    _data = results!.map((item) => Entry.fromMap(item)).toList();
    for (var element in _data) {
      _cards.add(EntryCard(entry: element));
    }
    setState(() {});
  }

  void _addEntries(Entry en) async {
    DB.insert(Entry.table, en);
    _fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar()),
      body: ListView(
        children: _cards,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MapPage()))
            .then((value) => _addEntries(value)),
        tooltip: 'Increment',
        backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}