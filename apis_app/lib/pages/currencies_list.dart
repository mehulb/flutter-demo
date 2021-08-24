import 'package:apis_app/services/currencies.dart';
import 'package:flutter/material.dart';

class CurrenciesList extends StatefulWidget {
  const CurrenciesList({Key? key}) : super(key: key);

  @override
  _CurrenciesListState createState() => _CurrenciesListState();
}

class _CurrenciesListState extends State<CurrenciesList> {

  var currencies = {};

  void fetchCurrencies() async {
    var obj = Currencies();
    await obj.fetch();
    currencies = obj.all;
    print(currencies);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Currencies"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          var key = currencies.keys.toList()[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                horizontalTitleGap: 8.0,
                // minLeadingWidth: 30.0,
                title: Text(
                  currencies[key],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "RobotMono",
                  ),
                ),
                leading: Card(
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                    child: Text(
                      key.toUpperCase(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "RobotMono",
                      ),
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
