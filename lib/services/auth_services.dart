import 'dart:convert';

import 'package:flutter_mona/model/dashboard.dart';
import 'package:flutter_mona/model/detailmodel.dart';
import 'package:flutter_mona/model/transactionmodel.dart';
import 'package:flutter_mona/model/usermodel.dart';
import 'package:flutter_mona/services/global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static Future<http.Response> register(
      String _name, String _email, String _password) async {
    Map data = {
      "name": _name,
      "email": _email,
      "password": _password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/register');
    http.Response response = await http.post(url, headers: headers, body: body);
    // ignore: avoid_print
    print(response.body);
    // ignore: avoid_print
    print(data);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    // ignore: avoid_print
    print(response.body);
    return response;
  }

  static Future<List<Transaction>> transaction() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString("api_token");
    String? id = localStorage.getString("id");

    var url = Uri.parse(baseURL + 'user/transaction/$token/$id');
    // ignore: avoid_print
    print(url);
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(response.body);
      // ignore: avoid_print
      print(token);
      // ignore: avoid_print
      print(id);
      return transactionFromJson(response.body);
    } else {
      throw Exception(['gagal mengambil transaksi']);
    }
    // ignore: avoid_print
  }

  static Future<Dash> dashboard() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString("api_token");
    String? id = localStorage.getString("id");

    var url = Uri.parse(baseURL + 'user/dashboard/$token/$id');
    // ignore: avoid_print
    print(url);
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(response.body);
      return dashFromJson(response.body.toString());
    } else {
      throw Exception(['gagal mengambil data']);
    }
    // ignore: avoid_print
  }

  static Future<User> info() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('api_token');
    var id = localStorage.getString('id');
    var url = Uri.parse(baseURL + 'user/info/$token/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    // ignore: avoid_print
    print(response.body);
    return userFromJson(response.body.toString());
  }

  static Future<http.Response> storeadd(
      String _id, String _jmluang, String _note) async {
    Map data = {"id": _id, "jml_uang": _jmluang, "note": _note};
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'transaction/storeadd');
    http.Response response = await http.post(url, headers: headers, body: body);
    // ignore: avoid_print
    print(response.body);
    // ignore: avoid_print
    print(body);
    return response;
  }

  static Future<http.Response> storeget(
      String _id, String _jmluang, String _note) async {
    Map data = {"id": _id, "jml_uang": _jmluang, "note": _note};
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'transaction/storeget');
    http.Response response = await http.post(url, headers: headers, body: body);
    // ignore: avoid_print
    print(response.body);
    // ignore: avoid_print
    print(body);
    return response;
  }

  static Future<Detail> show(String id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('api_token');
    var url = Uri.parse(baseURL + 'transaction/show/$token/$id');
    // ignore: avoid_print
    print(url);
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    // ignore: avoid_print
    print(response.body);
    var data = json.decode(response.body.toString());
    return Detail.fromJson(data);
  }

  static Future<http.Response> destroy(String _id) async {
    Map data = {"id": _id};
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'transaction/destroy');
    http.Response response = await http.post(url, headers: headers, body: body);
    // ignore: avoid_print
    print(response.body);
    // ignore: avoid_print
    print(body);
    return response;
  }
}
