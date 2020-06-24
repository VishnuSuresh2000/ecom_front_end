import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class ApiCalls {
  static bool dev=false;
  static var _client = Dio();
  static String _host = dev ?"http://localhost:8080":"https://immense-meadow-48383.herokuapp.com";

  static Future<List> read(String section) async {
    try {
      var res = await _client.get("$_host/${section.toLowerCase()}");

      return res.data['data'];
    } on DioError catch (e) {
      print(e);
      throw Exception(e.response.data['data']);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<String> create(
      String section, Map<String, dynamic> data) async {
    try {
      var res = await _client.post("$_host/${section.toLowerCase()}",
          options: Options(headers: {"Content-Type": "application/json"}),
          data: jsonEncode(data));

      return res.data['data'];
    } on DioError catch (e) {
      print(e);
      throw Exception(e.response.data['data']);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<String> update(
      String section, String id, Map<String, dynamic> data) async {
    try {
      var res = await _client.put("$_host/${section.toLowerCase()}/$id",
          options: Options(headers: {"Content-Type": "application/json"}),
          data: jsonEncode(data));

      return res.data['data'];
    } on DioError catch (e) {
      print(e);
      throw Exception(e.response.data['data']);
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
      return res.data['data'];
    } on DioError catch (e) {
      print(e);
      throw Exception(e.response.data['data']);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future customGet(String section, String urlSection) async {
    try {
      var res = await _client.get(
        "$_host/${section.toLowerCase()}/$urlSection",
        
      );
      return res.data['data'];
    } on DioError catch (e) {
      throw Exception(e.response.data['data']);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future customPut(
      String section, String urlSection, Map<String, dynamic> data) async {
    try {
      var res = await _client.put(
          "$_host/${section.toLowerCase()}/$urlSection",
          options: Options(headers: {"Content-Type": "application/json"}),
          data: jsonEncode(data));
      return res.data['data'];
    } on DioError catch (e) {
      throw Exception(e.response.data['data']);
    } catch (e) {
      print(e);
      throw e;
    }
  }
  static Future customPost(
      String section, String urlSection, Map<String, dynamic> data) async {
    try {
      var res = await _client.post(
          "$_host/${section.toLowerCase()}/$urlSection",
          options: Options(headers: {"Content-Type": "application/json"}),
          data: jsonEncode(data));
      return res.data['data'];
    } on DioError catch (e) {
      throw Exception(e.response.data['data']);
    } catch (e) {
      print(e);
      throw e;
    }
  }


  // static readStreamData() async {
  //   Response<ResponseBody>  res = await _client.get("http://localhost:8080/productlist/",
  //       options: Options(responseType: ResponseType.stream));
  //   // print(res.data.stream);
  //   res.data.stream.transform(StreamTransformer.fromBind((stream) => ));

  // }
}
