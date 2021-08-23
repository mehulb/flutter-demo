import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  const CountryDetails({Key? key}) : super(key: key);

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {

  var countryObj;

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
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                          child: Text(
                            countryObj["alpha3Code"],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),

                  Text(
                    countryObj["name"],
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.w100,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
