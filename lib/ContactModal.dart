import 'package:Loan/components/Components.dart';
import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ContactModal {
  static contactModalSheet(BuildContext context) {
    showMaterialModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        duration: const Duration(milliseconds: 200),
        builder: (context, scrollController) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Добавить новый"),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    _addNewUser(context),
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text("Из телефонной книги"),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Из существующих"),
                )
              ],
            ),
          );
        });
  }

  static _addNewUser(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Введите имя"),
            actions: <Widget>[
              FlatButton(
                child: Text('Отмена', style: TextStyle(color: Constans.Grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
               FlatButton(
                child: Text('Добавить', style: TextStyle(color: Constans.PrimaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MyInput(
                    placeholder: "Имя и фамилия",
                    onChanged: (value) => {
                      print(value)
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
