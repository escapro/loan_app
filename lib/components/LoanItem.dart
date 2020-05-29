import 'package:Loan/User.dart';
import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';

void main() => runApp(LoanItem());

class LoanItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (
      Container(
        child: _item(
          context: context
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Constans.UltraLightGrey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      )
    );
  }

  Widget _item({context}) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: Row(
                  children: <Widget>[
                    const Text("Андрей", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Constans.PrimaryColor)),
                    Icon(Icons.chevron_right)
                  ],
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => User(
                          userName: "Андрей",
                        )))
                },
              ),
              const Text("Создан сегодня", style: TextStyle(color: Constans.PrimaryColor),)
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
              const Text("150 AZN", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Text("Проход продолжает видеть частое использование...",
          style: const TextStyle(color: Constans.LightGrey))
      ],
    );
  }

}