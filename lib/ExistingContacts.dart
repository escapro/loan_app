import 'package:Loan/components/Components.dart';
import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';

class ExistingContacts extends StatefulWidget {
  final Function callback;

  ExistingContacts({Key key, this.callback}) : super(key: key);

  @override
  ExistingContactsState createState() => ExistingContactsState();
}

class ExistingContactsState extends State<ExistingContacts> {
  final items = List<String>.generate(15, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: "Существующие контакты",
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
                      children: <Widget>[
                        // Icon(Icons.flag, color: Constans.Grey,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text('${items[index]}'),
                        )
                      ],
                    ),
                    onTap: () => {
                      Navigator.of(context).pop(),
                      this.widget.callback('${items[index]}', 3)
                    },
                  )
                ),
              );
            },
          ),
        ));
  }
}