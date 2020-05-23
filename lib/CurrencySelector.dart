import 'package:Loan/components/Components.dart';
import 'package:Loan/components/LoanItem.dart';
import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';
import 'package:Loan/components/EmptyLoan.dart';

class CurrencySelector extends StatelessWidget {

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
              return ListItem(
                value: '${items[index]}',
              );
            },
          ),
        ));
  }
}

class ListItem extends StatelessWidget {

  final String value;

  ListItem({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: 
        BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Constans.UltraLightGrey
              )
          )
        ),
      child: (
        ListTile(
          title: Row(
            children: <Widget>[
              // Icon(Icons.flag, color: Constans.Grey,),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text("AZN - Азербайджанский манат"),
              )
            ],
          ),
          onTap: () => {print(value)},
          leading: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Roundel_of_Azerbaijan.svg/768px-Roundel_of_Azerbaijan.svg.png'),
            
          ),
        )
      ),
    );
  }
}