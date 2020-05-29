import 'package:flutter/material.dart';
import 'package:Loan/components/Components.dart';
import 'package:Loan/constans.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ContactList extends StatefulWidget {
  final Function callback;

  ContactList({Key key, this.callback}) : super(key: key);

  @override
  ContactListState createState() => ContactListState();
}

class ContactListState extends State<ContactList> {
  
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];

  int permissionType;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _askPermissions();
    _searchController.addListener(() {
      filterSearchResults();
    });
    // getAllContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _askPermissions() async {
    var status = await Permission.contacts.status;

    if (status.isUndetermined) {
      if (await Permission.contacts.request().isGranted) {
        permissionType = 1;
        _getAllContacts();
        print(status);
      }else {
        await Permission.contacts.request();
        permissionType = 2;
        print("Разрешение отклонено");
        print(status);
      }
    }else if(status.isPermanentlyDenied) {
      permissionType = 3;
      print("Restricted");
    }else {
      if(status.isGranted) {
        permissionType = 1;
        print("Разрешение уже присутсвует");
        print(status);
        _getAllContacts();
      }else if(status.isDenied) {
        permissionType = 2;
        await Permission.contacts.request();
        print("Разрешение уже отклонено");
        print(status);
      }
    }

    setState(() {});

  }

  _getAllContacts() async {
    Iterable<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    bool isSearching = _searchController.text.isNotEmpty;
    return MyAppBar(
        title: "Телефонная книга",
        divider: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Constans.PrimaryColor,
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              showInfoDialog();
            },
          )
        ],
        body: 
        this.permissionType == 1 ?
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: MyInput(
                  controller: _searchController,
                  placeholder: "Введите имя контакта",
                  icon: Icon(Icons.search, color: Constans.LightGrey),
                  suffixIcon: _searchController.text != '' ? 
                  InkWell(
                    child: Icon(Icons.clear, color: Constans.Grey),
                    onTap: (){
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  ) 
                  : null,
                  onChanged: (value){
                    setState(() {});
                  },
                ),
              ),
              Divider(height: 1, color: Constans.LightGrey),
              isSearching == false || contactsFiltered.isEmpty == false ?
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  cacheExtent: 500,
                  itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                  itemBuilder: (context, index) {
                    Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];
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
              ) : Expanded(
                child: Center(
                  child: Text("Не найдено", style: TextStyle(fontSize: 18)),
                ),
              )
            ],
          ),
        ) : 
        this.permissionType == 2 ?
        Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("Отказано в доступе к контактам",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center),
                ),
                Text("Разрешите приложению доступ к контактам",
                style: TextStyle(color: Constans.Grey),
                textAlign: TextAlign.center),
                MyButton(
                  text: "Разрешить доступ",
                  margin: EdgeInsets.only(top: 15.0),
                  onPressed: () async {
                    await _askPermissions();
                    sleep(const Duration(milliseconds: 500));
                    await _askPermissions();
                    // var status = await Permission.contacts.status;
                  },
                )
              ],
            )
          )
        ) :
        this.permissionType == 3 ?
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("Отказано в доступе к контактам",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center),
                ),
                Text("Перейдите в настройки и разрешите приложению доступ к контактам",
                style: TextStyle(color: Constans.Grey),
                textAlign: TextAlign.center),
                MyButton(
                  text: "Перейти к настройкам",
                  margin: EdgeInsets.only(top: 15.0),
                  onPressed: () async {
                    var status = await Permission.contacts.status;
                    if(!status.isGranted) {
                      openAppSettings();
                    }else {
                      _askPermissions();
                    }
                  },
                ),
              ],
            ),
          )
        ) 
        : null
        );
  }

  void filterSearchResults() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if(_searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact){
        String searchItem = _searchController.text.toLowerCase();
        String contactName = contact.displayName.toLowerCase();
        return contactName.contains(searchItem);
      });
      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  void showInfoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Информаци о телефонной книги"),
            actions: <Widget>[
              FlatButton(
                child: const Text('Понятно',
                    style: const TextStyle(color: Constans.PrimaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Lorem Ipsum является текст-заполнитель обычно используется в графических, печать и издательской индустрии для предварительного просмотра макета и визуальных макетах.")
                ],
              ),
            ),
          );
        });
  }
}