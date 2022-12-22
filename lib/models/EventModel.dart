class EventModel {
  final DateTime time;
  final String name;

  const EventModel({required this.time, required this.name});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      time: DateTime.tryParse(json['time'])!,
      name: json['name'],
    );
  }

  @override
  String toString() {
    return '$time $name';
  }
}
