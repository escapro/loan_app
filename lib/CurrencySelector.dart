import 'package:Loan/components/Components.dart';
import 'package:Loan/components/LoanItem.dart';
import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';
import 'package:Loan/components/EmptyLoan.dart';

class CurrencySelector extends StatefulWidget {
  
  final Function callback;

  CurrencySelector({Key key, this.callback}) : super(key: key);

  @override
  CurrencySelectorState createState() => CurrencySelectorState();
}

class CurrencySelectorState extends State<CurrencySelector> {
  final items = List<String>.generate(15, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: "Выберите валюту",
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: 
                  const BoxDecoration(
                    border: const Border(
                        bottom: const BorderSide(
                          color: Constans.UltraLightGrey
                        )
                    )
                  ),
                child: (
                  ListTile(
                    title: Row(
                      children: const <Widget>[
                        // Icon(Icons.flag, color: Constans.Grey,),
                        const Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: const Text("AZN - Азербайджанский манат"),
                        )
                      ],
                    ),
                    onTap: () => {
                      this.widget.callback('${items[index]}'),
                      Navigator.of(context).pop()
                    },
                    leading: const CircleAvatar(
                      radius: 15,
                      backgroundImage: const NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Roundel_of_Azerbaijan.svg/768px-Roundel_of_Azerbaijan.svg.png'),
                      
                    ),
                  )
                ),
              );
            },
          ),
        ));
  }
}