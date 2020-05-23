import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';

void main() => runApp(LoanItem());

class LoanItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (
      Container(
        child: _item(),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      )
    );
  }

  Widget _item() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Андрей", style: TextStyle(fontSize: 15),),
              Text("Создан сегодня")
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text("Взял в долг", style: TextStyle(fontSize: 17)),
              ),
              Text("150 AZN", style: TextStyle(fontSize: 25)),
            ],
          ),
        ),
        Text("Проход продолжает видеть частое использование, с Lorem Ipsum текст часто появляются в печати ...",
          style: TextStyle(color: Constans.LightGrey))
      ],
    );
  }

}