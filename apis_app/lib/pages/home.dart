import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget newCard({String? title, Function()? action}) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: action,
                child: Text(
                  title ?? "#NA",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          newCard(title: "Countries", action: (){
            Navigator.pushNamed(context, "/countries");
          }),
          newCard(title: "Currencies", action: (){
            Navigator.pushNamed(context, "/currencies");
          }),
        ],
      ),
    );
  }
}
