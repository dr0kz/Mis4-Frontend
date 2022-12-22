import 'dart:convert';

import 'package:exercise/models/EventModel.dart';
import 'package:exercise/service/event-service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'exam.dart';

class EventsCalendar extends StatefulWidget {
  const EventsCalendar({super.key});

  @override
  State<StatefulWidget> createState() {
    return EventsCalendarState();
  }
}

class EventsCalendarState extends State<EventsCalendar> {
  final EventService eventService = EventService();


  DateTime selectedDate = DateTime.now();
  Map<DateTime, List<EventModel>> map = <DateTime, List<EventModel>>{};

  bool sameDates(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  @override
  void initState() {
    super.initState();
    eventService.findMyEventsGroupedByDateTime().then((response) {
      Map<String, dynamic> s = json.decode(response.body);
      s.forEach((key, value) {
        var dateTime = DateTime.parse(key);
        map.putIfAbsent(DateTime(dateTime.year, dateTime.month, dateTime.day),
            () {
          Iterable list = value as Iterable<dynamic>;
          return list.map((e) => EventModel.fromJson(e)).toList();
        });
      });
    }).then((value) => print(map.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Terms')),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              selectedDayPredicate: (day) => day == selectedDate,
              onDaySelected: (date, events) {
                setState(() {
                  selectedDate = events;
                });
              },
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: selectedDate,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  for (DateTime d in map.entries
                      .map((e) => e.key)
                      .toList()) {
                    if (sameDates(day, d)) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  }
                  return null;
                },
              ),
            ),
            Expanded(
                child: SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: map.entries
                          .toList()
                          .where(
                              (element) => sameDates(element.key, selectedDate))
                          .length,
                      itemBuilder: (context, index) {
                        EventModel event = map.entries
                            .firstWhere((element) => sameDates(element.key, selectedDate))
                            .value[index];
                        return Exam(EventModel(name: event.name,time: event.time));
                      },
                    ))),
          ],
        ),
      ),
    );
  }
}
