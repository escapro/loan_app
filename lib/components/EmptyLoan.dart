import 'package:flutter/material.dart';

void main() => runApp(EmptyLoan());

class EmptyLoan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
            ),
            Text("Список долгов пуст", style: TextStyle(fontSize: 17))
          ],
        ),
      )
    );
  }
}