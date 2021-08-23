import 'package:apis_app/services/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  var countries = [];

  void fetchCountries() async {
    var obj = Countries();
    await obj.fetch();
    countries = obj.all;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Countries"),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  Navigator.pushNamed(context, "/country_details", arguments: countries[index]);
                },
                title: Text(countries[index]["name"]),
                leading: SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: SvgPicture.network(
                    countries[index]["flag"],
                    placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(12.0),
                      child: const CircularProgressIndicator(
                        strokeWidth: 1.0,
                        color: Colors.grey,
                      )
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
