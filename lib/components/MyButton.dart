import 'package:Loan/components/LoanItem.dart';
import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';
import 'package:Loan/components/EmptyLoan.dart';

class MyButton extends StatelessWidget {
  
  final String text;
  final Function onPressed;
  final bool isActive;

  MyButton({Key key, @required this.text, @required this.onPressed, this.isActive = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (RaisedButton(
      onPressed: () {onPressed();},
      child: Text(text, style: TextStyle(fontSize: 17)),
      color: isActive ? Constans.PrimaryColor : Colors.blue,
      textColor: Colors.white,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    ));
  }
}
