import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../consts/constant.dart';
import '../interceptor/HttpInterceptor.dart';

class EventService {

  Client client = InterceptedClient.build(interceptors: [
    HttpInterceptor(),
  ]);

  Future<Response> findMyEventsGroupedByDateTime() async {
    return await client
        .get(Constant.getFullUri('/api/events/my-events/grouped-by-date-time'));
  }

  Future<Response> findMyUpcomingEvents() async {
    return await client
        .get(Constant.getFullUri('/api/events/my-upcoming-events'));
  }

  Future<Response> save(String name, DateTime dateTime) async {
    return await client.post(Constant.getFullUri("/api/events"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'name': name, 'time': dateTime.toString()}));
  }

}
