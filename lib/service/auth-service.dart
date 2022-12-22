import 'dart:convert';

import 'package:exercise/consts/constant.dart';
import 'package:exercise/interceptor/HttpInterceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class AuthService {

  Client client = InterceptedClient.build(interceptors: [
    HttpInterceptor(),
  ]);

  Future<Response> login(String email, String password) async {
    return client.post(Constant.getFullUri("/api/auths/login"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}))
        .then((value) {
      if (value.statusCode == 200) {
        return value;
      }
      throw Exception(value.body);
    });
  }

  Future<Response> register(String name, String surname, String email,
      String password) async {
    return client.post(Constant.getFullUri("/api/auths/register"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'name': name,
          'surname': surname,
          'email': email,
          'password': password
        }))
        .then((value) {
      if (value.statusCode == 200) {
        return value;
      }
      throw Exception(value.body);
    });
  }
}
