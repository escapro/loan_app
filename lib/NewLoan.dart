import 'package:Loan/ContactModal.dart';
import 'package:Loan/CurrencySelector.dart';
import 'package:Loan/Date.dart';
import 'package:flutter/material.dart';
import 'package:Loan/constans.dart';
import 'components/Components.dart';

class NewLoan extends StatefulWidget {
  final int action;

  NewLoan({Key key, @required this.action}) : super(key: key);

  @override
  _NewLoanState createState() => _NewLoanState();
}

class _NewLoanState extends State<NewLoan> {

  int _amount=0;
  String _selectedCurrency;
  Map<int, List> _contacts;
  int _selectedAction;
  DateTime _startDate;
  DateTime _endDate;
  String _comment;

  @override
  void initState() {
    _selectedCurrency = "AZN";
    _selectedAction = widget.action;
    _startDate = DateTime.now();
   _contacts = {
      1   : ["Faiq", 1],
      2   : ["John", 2],
      3   : ["Steven", 1],
    }; 
    super.initState();
  }

  void currencyCallback(String currency) {
    setState(() {
      this._selectedCurrency = currency;
    });
  }

  void amountCallback(String value) {
    setState(() {
      this._amount = int.parse(value);
    });
  }

  void commentCallback(String value) {
    setState(() {
      this._comment = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (MyAppBar(
      title: "Новый долг",
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MySection(
                      title: "Сумма",
                      subtitle: "Введите сумму и укажите валюту",
                      divider: true,
                      body: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 3,
                            child: MyInput(
                                placeholder: "К примеру: 150",
                                margin: const EdgeInsets.only(right: 10.0),
                                keyboardType: TextInputType.number,
                                onChanged: this.amountCallback
                                ),
                          ),
                          Flexible(
                            flex: 1,
                            child: MyButton(
                              text: _selectedCurrency,
                              isActive: false,
                              textColor: Constans.StdBlack,
                              onPressed: () => {
                                FocusScope.of(context).requestFocus(new FocusNode()),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CurrencySelector(
                                              callback: this.currencyCallback,
                                            )))
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
                          const Expanded(
                              flex: 1,
                              child: const Icon(Icons.compare_arrows,
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
                          Container(
                            child: Expanded(
                              flex: 1,
                              child: MyButton(
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: const Icon(
                                        Icons.add_circle,
                                        size: 20,
                                      ),
                                    ),
                                    const Text("Добавить контакт",
                                        style: const TextStyle(fontSize: 15)
                                    )
                                  ],
                                ),
                                onPressed: () => {ContactModal.contactModalSheet(context)},
                              ),
                            ),
                          ),
                          Container(
                            child: Text("asd"),
                          )
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
                                  type: 1,
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
                          const Expanded(
                              flex: 1,
                              child: const Icon(Icons.arrow_forward,
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
                                    type: 2,
                                    initialDate: _endDate == null ? _startDate : _endDate,
                                    firstDate: _endDate == null ? _startDate : _startDate,
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
                              onChanged: this.commentCallback,
                            ),
                          )
                        ],
                      )),
                    FlatButton(
                      color: Constans.PrimaryColor,
                      child: Text("asd"),
                      onPressed: () {
                        print("-----------------------------------");
                        print("Amount: $_amount");
                        print("Currency: $_selectedCurrency");
                        print("Action: $_selectedAction");
                        print("Contacts: $_contacts");
                        print("Start date: $_startDate");
                        print("End date: $_endDate");
                        print("Comment: $_comment");
                        print("-----------------------------------");
                      },
                    )
                ],
              )),
        ),
      ),
    ));
  }
}
