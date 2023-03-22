class Entry {

  String date;
  String duration;
  double speed;
  double distance;

  Entry({ required this.date, required this.duration, required this.speed, required this.distance});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'duration': duration,
      'speed': speed,
      'distance': distance
    };

    return map;
  }

  static Entry fromMap(Map<String, dynamic> map) {
    return Entry(
        date: map['date'],
        duration: map['duration'],
        speed: map['speed'],
        distance: map['distance']);
  }
}