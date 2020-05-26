import 'package:flutter/material.dart';

void main() => runApp(EmptyLoan());

class EmptyLoan extends StatelessWidget {

  const EmptyLoan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: const Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
            ),
            const Text("Список долгов пуст", style: const TextStyle(fontSize: 17))
          ],
        ),
      )
    );
  }
}