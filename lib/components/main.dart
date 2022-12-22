import 'dart:convert';

import 'package:exercise/components/events-calendar.dart';
import 'package:exercise/components/exam.dart';
import 'package:exercise/components/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../models/EventModel.dart';
import '../service/event-service.dart';
import '../service/notification-service.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Login()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final EventService eventService = EventService();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    eventService.findMyUpcomingEvents().then((response) {
      Iterable list = json.decode(response.body) as Iterable<dynamic>;
      List<EventModel> upcomingEvents =  list.map((e) => EventModel.fromJson(e)).toList();
      NotificationService().showNotification(1, "Upcoming Events", upcomingEvents.map((e) => '${e.name} at ${e.time}').join(", "), 5);
    });
  }

  void _onExamTermAdd() {
    setState(() {
      exams.add(EventModel(time: examTime, name: name.text));
      eventService.save(name.text, examTime);
    });
  }

  final name = TextEditingController();
  DateTime examTime = DateTime.now();

  List<EventModel> exams = <EventModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          appBar: AppBar(
            title: const Text('Exam Terms'),
            actions: [
              IconButton(
                  icon: const Icon(Icons.calendar_month),
                  tooltip: 'Calendar',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const EventsCalendar()),
                  )),
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Add Exam',
                onPressed: () => _onExamTermAdd(),
              ),
            ],
          ),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter subject name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      examTime = date;
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: const Text(
                    'Set exam time',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Expanded(
                child: SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: exams.length,
                      itemBuilder: (context, index) {
                        return Exam(exams[index]);
                      },
                    ))),
          ])),
    );
  }
}
