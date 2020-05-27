import 'package:Loan/components/Components.dart';
import 'package:flutter/material.dart';

class User extends StatelessWidget {

  final String userName;

  // In the constructor, require a Todo.
  User({Key key, @required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: this.userName,
      body: Center(
        child: Text("Asdsad"),
      ),
    );
  }
}
