import 'package:flutter/material.dart';
import 'package:Loan/constans.dart';
import 'package:Loan/NewLoan.dart';

class MyAppBar extends StatelessWidget {

  String title;
  var body;

  MyAppBar({Key key, @required this.title, @required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        appBar: AppBar(
          title:
              Text(title, style: TextStyle(color: Constans.StdBlack)),
          elevation: 0,
          shape: Border(bottom: BorderSide(color: Constans.Grey)),
          iconTheme: IconThemeData(
            color: Constans.PrimaryColor
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: body
      )
    );
  }
}
