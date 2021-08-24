import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Currencies {
  var all;

  Future<void> fetch() async {
    try {
      var url = Uri.https("cdn.jsdelivr.net", "/gh/fawazahmed0/currency-api@1/latest/currencies.json");
      var response = await http.get(url);
      var info = jsonDecode(response.body);
      all = info;
    } catch (e) {
      print("ERR# $e");
    }
  }

  Future<void> fetchDetails({String? currency, DateTime? date}) async {
    if (currency == null) {
      print("ERR# Currency is null");
    } else {
      var dateStr = "latest";
      if (date != null) {

      }

      try {
        var url = Uri.https("cdn.jsdelivr.net", "/gh/fawazahmed0/currency-api@1/$dateStr/currencies/$currency.json");
        var response = await http.get(url);
        var info = jsonDecode(response.body);
        all = info;
      } catch (e) {
        print("ERR# $e");
      }
    }
  }
}