import 'package:exercise/models/EventModel.dart';
import 'package:flutter/material.dart';

class Exam extends StatelessWidget {
  EventModel examModel;

  Exam(this.examModel);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      margin: const EdgeInsets.all(2),
      child: Column(
        children: [
          Text(examModel.name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(examModel.time.toString(), style: const TextStyle(color: Colors.black12))
        ],
      ),
    ));
  }
}
