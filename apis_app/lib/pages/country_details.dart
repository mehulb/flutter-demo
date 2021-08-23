import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryDetails extends StatefulWidget {
  const CountryDetails({Key? key}) : super(key: key);

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {

  var countryObj;

  Future<void> openMap({double? latitude, double? longitude}) async {
    if (latitude == null || longitude == null) {
      throw "Location params are invalid";
    }
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Widget detailWidget({IconData icon = Icons.error, String key = "#NA", String subkey = "", String subsubkey = ""}) {
    var _value = countryObj[key];
    // print("$key - ${_value.runtimeType.toString()}");
    var values = [];
    if (_value.runtimeType == int || _value.runtimeType == double) {
      var format = NumberFormat.compact();
      values.add(format.format(_value));
    } else if (_value is List) {
      // print("list found ${_value.length}");
      for (var item in _value) {
        // print("QQ $item - ${item.runtimeType}");
        if (item.runtimeType == String) {
          values.add(item);
        } else if (item is Map) {
          if (subkey.isEmpty) {
            item.values.forEach((element) {
              values.add(element);
            });
          } else {
            var str = item[subkey];
            if (subsubkey.isNotEmpty) {
              str += " (${item[subsubkey]})";
            }
            values.add(str);
          }
        } else {
          values.add("#UnknownType");
        }
      }
    } else if (_value.runtimeType == String && _value.toString().isNotEmpty) {
      values.add(_value);
    }

    if (values.isEmpty) {
      values.add("#NA");
    }

    List<Widget> colWidgets = [];
    values.forEach((element) {
      var widget = Text(
        element,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22.0,
            color: (element == "#NA") ? Colors.grey : Colors.black,
        ),
      );
      colWidgets.add(widget);
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 18.0,
            ),
          ),
          SizedBox(width: 8.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: colWidgets,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final route = ModalRoute.of(context);
    if (route != null) {
      final args = route.settings.arguments;
      if (args != null) {
        countryObj = args;
      }
    }
    print(countryObj);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: Card(
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                            child: Text(
                              countryObj["alpha3Code"] ?? "#NA",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SvgPicture.network(
                    countryObj["flag"],
                    fit: BoxFit.fitWidth,
                    height: 240,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const CircularProgressIndicator(
                          strokeWidth: 1.0,
                          color: Colors.grey,
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                    child: Text(
                      countryObj["name"] ?? "#NA",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Divider(height: 0.0,),
                  SizedBox(height: 12.0,),
                  Expanded(child: ListView(
                    children: [
                      detailWidget(key: "demonym", icon: Icons.person_outline),
                      detailWidget(key: "capital", icon: Icons.location_city_outlined),
                      detailWidget(key: "region", icon: Icons.public_outlined),
                      detailWidget(key: "population", icon: Icons.groups_outlined),
                      detailWidget(key: "area", icon: Icons.landscape_outlined),
                      detailWidget(key: "timezones", icon: Icons.schedule_outlined),
                      detailWidget(key: "callingCodes", icon: Icons.phone_outlined),
                      detailWidget(key: "currencies", subkey: "name", subsubkey: "symbol", icon: Icons.savings_outlined),
                      detailWidget(key: "languages", subkey: "name", subsubkey: "nativeName", icon: Icons.translate),
                    ],
                  ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                    child: OutlinedButton.icon(
                      onPressed: (){
                        var latlong = countryObj["latlng"];
                        openMap(latitude: latlong[0], longitude: latlong[1]);
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        side: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      icon: Icon(Icons.map),
                      label: Text("Open in Maps"),
                    ),
                  )
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
