import 'package:Loan/components/Components.dart';
import 'package:Loan/components/LoanItem.dart';
import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';
import 'package:Loan/components/EmptyLoan.dart';
import 'package:intl/intl.dart';

class CurrencySelector extends StatefulWidget {
  final Function callback;

  CurrencySelector({Key key, this.callback}) : super(key: key);

  @override
  CurrencySelectorState createState() => CurrencySelectorState();
}

class CurrencySelectorState extends State<CurrencySelector> {
  TextEditingController _searchController = TextEditingController();

  List<List> _currencies = [
    ['RUB', 'Росийский рубль', '₽', 'ru'],
    ['USD', 'Доллар США', '\$', 'us'],
    ['EUR', 'Евро', '', 'eu'],
    ['UAH', 'Украинская гривна', '₴', 'ua'],
    ['BYR', 'Белорусский рубль', 'Br', 'by'],
    ['KZT', 'Казахстанский тенге', '₸', 'kz'],
    ['GEL', 'Грузинский лари', "₾", 'ge'],
    ['AZN', 'Азербайджанский манат', '₼', 'az'],
    ['AMD', 'Армянский драм', '֏', 'am'],
    ['UZS', 'Узбекский сум', "so'm", 'uz'],
    ['TJS', 'Таджикский сомони', "с", 'tj'],
  ];

  var searchItems = List<List>();

  @override
  void initState() {
    super.initState();
    searchItems.addAll(_currencies);
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: "Выберите валюту",
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
              Container(
                padding: EdgeInsets.only(
                    right: 10.0, left: 10.0, top: 0, bottom: 10.0),
                child: MyInput(
                  controller: _searchController,
                  placeholder: "Введите валюту",
                  icon: Icon(Icons.search, color: Constans.LightGrey),
                  suffixIcon: _searchController.text != ''
                      ? InkWell(
                          child: Icon(Icons.clear, color: Constans.Grey),
                          onTap: () {
                            setState(() {
                              _searchController.clear();
                              filterSearchResults(
                                  _searchController.text.toString());
                            });
                          },
                        )
                      : null,
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                ),
              ),
              Divider(height: 1, color: Constans.UltraLightGrey),
              searchItems.isEmpty == false
                  ? Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: searchItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: const BoxDecoration(
                                  border: const Border(
                                      bottom: const BorderSide(
                                          color: Constans.UltraLightGrey))),
                              child: (ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      // Icon(Icons.flag, color: Constans.Grey,),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        '${searchItems[index][0]} ',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                TextSpan(
                                                    text:
                                                        NumberFormat.simpleCurrency(name: '${searchItems[index][0]}').currencySymbol,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black38)),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                  subtitle: Text('${searchItems[index][1]}'),
                                  onTap: () => {
                                        this.widget.callback(
                                            '${searchItems[index][0]}'),
                                        Navigator.of(context).pop()
                                      },
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Constans
                                                    .MegaUltraLightGrey)),
                                        child: Image.asset(
                                          'assets/images/countries/${searchItems[index][3]}.png',
                                          // width: 30,
                                          // height: 30,
                                          alignment: Alignment.center,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ))),
                            );
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child:
                            Text("Не найдено", style: TextStyle(fontSize: 18)),
                      ),
                    ),
            ],
          ),
        ));
  }

  void filterSearchResults(String query) {
    List<List> searchList = List<List>();
    searchList.addAll(_currencies);
    if (query.isNotEmpty) {
      List<List> dummyListData = List<List>();
      searchList.forEach((country) {
        var searchLine = country[0] + ' ' + country[1];
        if (searchLine.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(country);
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
        searchItems.addAll(_currencies);
      });
    }
  }

  void showInfoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Информаци о валютах"),
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
