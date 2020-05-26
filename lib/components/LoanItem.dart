import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';

void main() => runApp(LoanItem());

class LoanItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (
      Container(
        child: _item(),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3), // changes position of shadow
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
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              const Text("Андрей", style: const TextStyle(fontSize: 15),),
              const Text("Создан сегодня")
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: const <Widget>[
              const Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: const Text("Взял в долг", style: const TextStyle(fontSize: 17)),
              ),
              const Text("150 AZN", style: const TextStyle(fontSize: 25)),
            ],
          ),
        ),
        const Text("Проход продолжает видеть частое использование, с Lorem Ipsum текст часто появляются в печати ...",
          style: const TextStyle(color: Constans.LightGrey))
      ],
    );
  }

}