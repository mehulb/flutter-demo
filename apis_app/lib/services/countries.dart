import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Countries {
  var all;

  Future<void> fetch() async {
    try {
      var url = Uri.https("restcountries.eu", "/rest/v2/all");
      var response = await http.get(url);
      var info = jsonDecode(response.body);

      all = info;
    } catch (e) {
      print("ERR# $e");
    }
  }
}