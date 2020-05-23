import 'package:Loan/CurrencySelector.dart';
import 'package:Loan/Date.dart';
import 'package:flutter/material.dart';
import 'package:Loan/constans.dart';
import 'components/Components.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class NewLoan extends StatefulWidget {
  final int action;

  NewLoan({Key key, @required this.action}) : super(key: key);

  @override
  _NewLoanState createState() => _NewLoanState();
}

class _NewLoanState extends State<NewLoan> {
  String _selectedCurrency;
  int _selectedAction;
  DateTime _startDate;
  DateTime _endDate;

  @override
  void initState() {
    _selectedCurrency = "AZN";
    _selectedAction = widget.action;
    _startDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (MyAppBar(
      title: "Новый долг",
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MySection(
                    title: "Сумма",
                    subtitle: "Введите сумму и валюту",
                    divider: true,
                    body: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: MyInput(
                              placeholder: "К примеру: 150",
                              margin: EdgeInsets.only(right: 10.0)),
                        ),
                        Flexible(
                          flex: 1,
                          child: MyButton(
                            text: _selectedCurrency,
                            isActive: false,
                            textColor: Constans.StdBlack,
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (oldContext) =>
                                          CurrencySelector()))
                            },
                          ),
                        )
                      ],
                    )),
                MySection(
                    title: "Действие",
                    subtitle: "Выберите один из действий",
                    divider: true,
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: MyButton(
                            text: "Взял в долг",
                            isActive: _selectedAction == 1 ? true : false,
                            onPressed: () => {
                              setState(() {
                                _selectedAction = 1;
                              })
                            },
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.compare_arrows,
                                size: 30, color: Constans.Grey)),
                        Expanded(
                          flex: 3,
                          child: MyButton(
                            text: "Дал в долг",
                            isActive: _selectedAction == 2 ? true : false,
                            onPressed: () => {
                              setState(() {
                                _selectedAction = 2;
                              })
                            },
                          ),
                        ),
                      ],
                    )),
                MySection(
                    title: "Контакты",
                    subtitle: "Укажите контакты",
                    infoText: "Можно выбирать несколько контактов",
                    divider: true,
                    body: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: MyButton(
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    Icons.add_circle,
                                    size: 20,
                                  ),
                                ),
                                Text("Добавить контакт",
                                    style: TextStyle(fontSize: 15))
                              ],
                            ),
                            onPressed: () => {},
                          ),
                        ),
                      ],
                    )),
                MySection(
                    title: "Дата",
                    subtitle: "Выберите промежуток дейстия долга",
                    infoText:
                        "Можно выбирать дату начала и дату конца действия долга",
                    divider: true,
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: MyButton(
                            text: _startDate == null
                                  ? "Укажите дату"
                                  : Date.format(_startDate),
                            isActive: true,
                            onPressed: () => {
                              Date.showPicker(
                                context: context,
                                initialDate: _startDate,
                                lastDate: _endDate,
                                callable: (pickedDate) => {
                                  if (pickedDate != null) {
                                    setState(() {
                                      _startDate = pickedDate;
                                    })
                                  },
                                }
                              )
                            },
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.arrow_forward,
                                size: 30, color: Constans.Grey)),
                        Expanded(
                          flex: 3,
                          child: MyButton(
                              text: _endDate == null
                                  ? "Укажите дату"
                                  : Date.format(_endDate),
                              isActive: _endDate == null ? false : true,
                              onPressed: () => {
                                Date.showPicker(
                                  context: context,
                                  initialDate: _endDate != null ? _endDate : _startDate,
                                  firstDate: _startDate,
                                  callable: (pickedDate) => {
                                    if (pickedDate != null) {
                                      setState(() {
                                        _endDate = pickedDate;
                                      })
                                    },
                                  }
                                )
                              }),
                        ),
                      ],
                    )),
                MySection(
                    title: "Комментарий",
                    subtitle: "Введите заметку к записи",
                    infoText: "Необязательное поле",
                    body: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: MyInput(
                            placeholder: "Заметка к записи долга",
                            maxLines: 4,
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
    ));
  }

  // currencyDialog(context) {
  //   return showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Выберите валюту"),
  //           actions: <Widget>[
  //             MaterialButton(
  //               onPressed: () {
  //                 Navigator.of(context, rootNavigator: true)
  //                     .pop('currencyDialog');
  //               },
  //               child: Text("Отмена"),
  //             )
  //           ],
  //           content: Column(
  //             children: <Widget>[
  //               Radio(
  //                 value: "AZN",
  //                 groupValue: _selectedCurrency,
  //                 onChanged: (value) {_setCurrencyValue(value);},
  //               ),
  //               Radio(
  //                 value: "USD",
  //                 groupValue: _selectedCurrency,
  //                 onChanged: (value) {_setCurrencyValue(value);},
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}
