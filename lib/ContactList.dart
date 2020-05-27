import 'package:flutter/material.dart';
import 'package:Loan/components/Components.dart';
import 'package:Loan/constans.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactList extends StatefulWidget {
  final Function callback;

  ContactList({Key key, this.callback}) : super(key: key);

  @override
  ContactListState createState() => ContactListState();
}

class ContactListState extends State<ContactList> {
  final items = List<String>.generate(15, (i) => "Item $i");
  
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _askPermissions();
    // getAllContacts();
  }

  Future<void> _askPermissions() async {
    var status = await Permission.contacts.status;

    if (status.isUndetermined) {
      if (await Permission.contacts.request().isGranted) {
        _getAllContacts();
        print(status);
      }else {
        print("Разрешение отклонено");
        print(status);
      }
    }else {
      if(status.isGranted) {
        print("Разрешение уже присутсвует");
        print(status);
        _getAllContacts();
      }else if(status.isDenied) {
        print("Разрешение уже отклонено");
        print(status);
      }
    }

    Future<void> _getPermission() async {
      status = await Permission.contacts.status;
    }

  }

  _getAllContacts() async {
    Iterable<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: "Телефонная книга",
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Contact contact = contacts[index];
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
                    title: Text(contact.displayName),
                    subtitle: Text(contact.phones.elementAt(0).value),
                    leading: (contact.avatar != null && contact.avatar.length > 0) ?
                    CircleAvatar(
                      backgroundImage: MemoryImage(contact.avatar),
                    ) : 
                    CircleAvatar(
                      child: Text(contact.initials()),
                    ),
                    onTap: () => {
                      Navigator.of(context).pop(),
                      this.widget.callback('${contact.displayName}', 2)
                    },
                  )
                ),
              );
            },
          ),
        ));
  }
}