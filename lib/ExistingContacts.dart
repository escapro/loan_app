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
  var searchItems = List<String>();
  String _searchValue;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchValue='';
    _searchController = new TextEditingController(text: _searchValue);
    searchItems.addAll(items);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: "Сохраненные контакты",
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
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: MyInput(
                  controller: _searchController,
                  placeholder: "Введите имя контакта",
                  icon: Icon(Icons.search, color: Constans.LightGrey),
                  suffixIcon: _searchValue != '' ? 
                  InkWell(
                    child: Icon(Icons.clear, color: Constans.Grey),
                    onTap: (){
                      setState(() {
                        _searchValue='';
                        filterSearchResults(_searchValue);
                        _searchController.clear();
                      });
                    },
                  ) 
                  : null,
                  onChanged: (value){
                    _searchValue=value;
                    filterSearchResults(_searchValue);
                  },
                )
              ),
              Divider(height: 1, color: Constans.UltraLightGrey),
              searchItems.isEmpty == false ?
              Expanded(
                child: ListView.builder(
                  itemCount: searchItems.length,
                  shrinkWrap: true,
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
                                child: Text('${searchItems[index]}'),
                              )
                            ],
                          ),
                          onTap: () => {
                            Navigator.of(context).pop(),
                            this.widget.callback('${searchItems[index]}', 3)
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
              ),
            ],
          ),
        ));
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(items);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        searchItems.clear();
        searchItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        searchItems.clear();
        searchItems.addAll(items);
      });
    }
  }

  void showInfoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Информация о сохраненных контактах"),
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