import 'package:Loan/ContactList.dart';
import 'package:Loan/ExistingContacts.dart';
import 'package:Loan/components/Components.dart';
import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ContactModal {
  
  Function callback;
  String newContactName;

  ContactModal({BuildContext context, Function callback}) {

    this.callback = callback;

    showMaterialModalBottomSheet(
        context: context,
        enableDrag: true,   
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        isDismissible: true,
        // duration: const Duration(milliseconds: 200),
        builder: (context, scrollController) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("Добавить новый"),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    addNewUser(context),
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contacts),
                  title: const Text("Из телефонной книги"),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (oldContext) => ContactList(
                          callback: this.contactListCallback
                        )
                      )
                    )
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Из существующих"),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (oldContext) => ExistingContacts(
                          callback: this.existingContactsCallback
                        )
                      )
                    )
                  },
                ),
                Divider(color: Constans.LightGrey),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: const Text("Закрыть"),
                  onTap: () => {
                    Navigator.of(context).pop(),
                  },
                )
              ],
            ),
          );
        });
  }

  void contactListCallback(String name, int type) {
    newContactName=name;
    this.callback([newContactName, 2], type);
    newContactName=null;
  }

  void existingContactsCallback(String name, int type) {
    newContactName=name;
    this.callback([newContactName, 1], type);
    newContactName=null;
  }

  addNewUser(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Введите новый контакт"),
            actions: <Widget>[
              FlatButton(
                child: const Text('Отмена', style: const TextStyle(color: Constans.Grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
               FlatButton(
                child: const Text('Добавить', style: const TextStyle(color: Constans.PrimaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                  this.callback([newContactName, 1], 1);
                  newContactName=null;
                },
              ),
            ],
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Имя и фамилия",
                      contentPadding: EdgeInsets.all(0),
                    ),
                    onChanged: (value) => {
                      newContactName=value
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
