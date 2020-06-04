import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCalls {
  static var _client = http.Client();
  static String _host = "http://localhost:8080";

  static Future<List> read(String section) async {
    try {
      var res = await _client.get("$_host/${section.toLowerCase()}");
      var obj = json.decode(res.body);
      if (res.statusCode == 400) {
        throw Exception(obj['data']);
      }
      return obj['data'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<String> create(
      String section, Map<String, dynamic> data) async {
    try {
      var res = await _client.post("$_host/${section.toLowerCase()}",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      var obj = json.decode(res.body);
      if (res.statusCode == 400) {
        throw Exception(obj['data']);
      }
      return obj['data'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<String> update(
      String section, String id, Map<String, dynamic> data) async {
    try {
      var res = await _client.put("$_host/${section.toLowerCase()}/$id",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      var obj = json.decode(res.body);
      if (res.statusCode == 400) {
        throw Exception(obj['data']);
      }
      return obj['data'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<String> delete(String section, String id) async {
    try {
      var res = await _client.delete(
        "$_host/${section.toLowerCase()}/$id",
      );
      var obj = json.decode(res.body);
      if (res.statusCode == 400) {
        throw Exception(obj['data']);
      }
      return obj['data'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future customGet(String section,String urlSection) async{
    try {
      var res = await _client.get(
        "$_host/${section.toLowerCase()}/$urlSection",
      );
      var obj = json.decode(res.body);
      if (res.statusCode == 400) {
        throw Exception(obj['data']);
      }
      return obj['data'];
    } catch (e) {
      print(e);
      throw e;
    }

  }

}
