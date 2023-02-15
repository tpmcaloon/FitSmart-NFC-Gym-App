import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogWorkoutPage extends StatefulWidget {
  const LogWorkoutPage({super.key});

  @override
  _LogWorkoutPageState createState() => _LogWorkoutPageState();
}

class _LogWorkoutPageState extends State<LogWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  late String _date;
  late String _type;
  late String _duration;
  late String _notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Workout')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Date'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a date';
                }
                return null;
              },
              onSaved: (value) => _date = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Type'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a type of workout';
                }
                return null;
              },
              onSaved: (value) => _type = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Duration'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the duration of the workout';
                }
                return null;
              },
              onSaved: (value) => _duration = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Notes'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter any notes';
                }
                return null;
              },
              onSaved: (value) => _notes = value!,
            ),
            ElevatedButton(
              child: const Text('Log Workout'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _firestore
                      .collection('workouts')
                      .add({'date': _date, 'type': _type, 'duration': _duration, 'notes': _notes});
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}