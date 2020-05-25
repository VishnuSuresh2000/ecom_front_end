import 'dart:convert';

import 'package:http/http.dart'as http;

class ApiCalls{
  static var _client=http.Client();
  static String _host="http://localhost:8080";

  static Future<Map<String,dynamic>> read(String section) async{
    try {
      var res= await _client.get("$_host/$section");
      
      return json.decode(res.body);
    } catch (e) {
      print(e);
      return {"msg":"front end error fun:read \n$e","error":true};
    }
  }
}