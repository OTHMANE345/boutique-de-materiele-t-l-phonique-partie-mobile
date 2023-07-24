import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url =
      "https://pageofcode99.000webhostapp.com/api/";
  Future<Map<String, dynamic>> postData(
      Map<String, String> data, String apiUrl) async {
    var FullUrl = _url + apiUrl + await _getToken();
    ;
    final response = await http.post(
      Uri.parse(FullUrl),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Something went wrong');
    }
  }
  Future<Map<String, String>> postDataforcart(
      Map<String, String> data, String apiUrl) async {
    var FullUrl = _url + apiUrl ;
    ;
    final response = await http.post(
      Uri.parse(FullUrl),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Something went wrong');
    }
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

  Future<http.Response> getPublicData(String apiUrl) async {
    var fullUrl = _url + apiUrl;
    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Something went wrong');
    }
  }



  Future<http.Response> postDataforgettingcarts(
      Map<String, String> data, String apiUrl) async {
    var FullUrl = _url + apiUrl + await _getToken();
    ;
    final response = await http.post(
      Uri.parse(FullUrl),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Something went wrong');
    }
  }



  Future<dynamic> getPublicDataforCart(String apiUrl) async {
    var fullUrl = _url + apiUrl;
    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      return jsonData;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
