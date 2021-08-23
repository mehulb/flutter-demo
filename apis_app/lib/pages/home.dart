import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/countries");
                    },
                    child: Text(
                      "Countries",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
