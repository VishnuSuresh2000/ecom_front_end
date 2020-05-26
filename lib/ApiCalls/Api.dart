import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCalls {
  static var _client = http.Client();
  static String _host = "http://localhost:8080";

  static Future<Map<String, dynamic>> read(String section) async {
    try {
      var res = await _client.get("$_host/${section.toLowerCase()}");
      return json.decode(res.body);
    } catch (e) {
      print(e);
      return {"msg": "front end error fun:read \n$e", "error": true};
    }
  }

  static Future<Map<String, dynamic>> create(
      String section, Map<String, dynamic> data) async {
    try {
      var res = await _client.post("$_host/${section.toLowerCase()}",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      return json.decode(res.body);
    } catch (e) {
      print(e);
      return {"msg": "front end error fun:create \n$e", "error": true};
    }
  }

  static Future<Map<String, dynamic>> update(
      String section, String id, Map<String, dynamic> data) async {
        print(data);
    try {
      var res = await _client.put("$_host/${section.toLowerCase()}/$id",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      return json.decode(res.body);
    } catch (e) {
      print(e);
      return {"msg": "front end error fun:update \n$e", "error": true};
    }
  }

  static Future<Map<String, dynamic>> delete(String section, String id) async {
    try {
      var res = await _client.delete(
        "$_host/${section.toLowerCase()}/$id",
      );
      return json.decode(res.body);
    } catch (e) {
      print(e);
      return {"msg": "front end error fun:update \n$e", "error": true};
    }
  }
}
