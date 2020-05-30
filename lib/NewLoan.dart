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
  int _amount = 0;
  String _selectedCurrency;
  Map<int, List> _contacts;
  int _selectedAction;
  DateTime _startDate;
  DateTime _endDate;
  String _comment;
  BuildContext _context;

  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedCurrency = "AZN";
    _selectedAction = widget.action;
    _startDate = DateTime.now();
    _contacts = {
      1: ["Faiq", 1],
      2: ["John", 2],
      3: ["Steven", 1],
      4: ["Emily", 1],
      5: ["Bryan", 1],
    };
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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

  void newContactCallback(List contact, int type) {
    setState(() {
      var allow = true;

      this._contacts.forEach((key, value) {
        if(value.contains(contact[0])) {
          allow = false;
        }
      });

      if(allow) {
        this._contacts.addAll({_contacts.length+1: contact});
      }else {
        _showContactRepeatDialog(
          context: this._context,
          type: type
        );
      }
    });
  }

  Widget _contactList() {
    List<Widget> list = new List<Widget>();

    _contacts.forEach((key, value) {
      list.add(
        Container(
          child: Chip(
            padding: const EdgeInsets.all(15.0),
            backgroundColor: Constans.MegaUltraLightGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular((10))
              )
            ),
            onDeleted: () {
              setState(() {
                _contacts.remove(key);
              });
            },
            label: Text(value[0].toString(), style: const TextStyle(color: Constans.StdBlack, fontSize: 16))
          ),
        )
      );
    });

    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(
        top: 10,
      ),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        alignment: WrapAlignment.start,
        children: list,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return (MyAppBar(
      title: "Новый долг",
      body: Scrollbar(
        child: SafeArea(
          child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: <Widget>[
                  MySection(
                      title: 'Сумма',
                      subtitle: "Введите сумму и укажите валюту",
                      divider: true,
                      body: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 3,
                            child: MyInput(
                              controller: _amountController,
                              placeholder: "К примеру: 150",
                              maxLenght: 11,
                              suffixIcon: 
                              _amountController.text != '' ?
                              InkWell(
                                child: Icon(Icons.add, color: Constans.LightGrey),
                                onTap: () {
                                  String value = _amountController.text;
                                  if(value.split('').last != '+') {
                                    value += '+';
                                  }
                                  _amountController.value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.fromPosition(
                                      TextPosition(offset: value.length),
                                    ),
                                  );
                                },
                              ) : null,
                              margin: const EdgeInsets.only(right: 10.0),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              onChanged: amountListener),
                          ),
                          Flexible(
                            flex: 1,
                            child: MyButton(
                              text: _selectedCurrency,
                              isActive: false,
                              textColor: Constans.StdBlack,
                              onPressed: () => {
                                unfocus(),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CurrencySelector(
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
                                unfocus(),
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
                                unfocus(),
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
                      body: Column(
                        children: <Widget>[
                          Container(
                            child: MyButton(
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  const Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: const Icon(
                                      Icons.add_circle,
                                      size: 20,
                                    ),
                                  ),
                                  const Text("Добавить контакт",
                                      style: const TextStyle(fontSize: 15))
                                ],
                              ),
                              onPressed: ()
                                  {
                                    unfocus();
                                    this._context=context;
                                    return ContactModal(
                                      context: context,
                                      callback: this.newContactCallback
                                    );
                                  },
                            ),
                          ),
                          if (_contacts.length != 0) _contactList()
                        ],
                      )),
                  MySection(
                      title: "Дата",
                      subtitle: "Выберите промежуток действия долга",
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
                              fontSize: 13,
                              onPressed: () => {
                                unfocus(),
                                Date.showPicker(
                                    context: context,
                                    type: 1,
                                    initialDate: _startDate,
                                    lastDate: _endDate,
                                    callable: (pickedDate) => {
                                          if (pickedDate != null)
                                            {
                                              setState(() {
                                                _startDate = pickedDate;
                                              })
                                            },
                                        })
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
                                fontSize: 13,
                                onPressed: () => {
                                  unfocus(),
                                      Date.showPicker(
                                          context: context,
                                          type: 2,
                                          initialDate: _endDate == null
                                              ? _startDate
                                              : _endDate,
                                          firstDate: _endDate == null
                                              ? _startDate
                                              : _startDate,
                                          callable: (pickedDate) => {
                                                if (pickedDate != null)
                                                  {
                                                    setState(() {
                                                      _endDate = pickedDate;
                                                    })
                                                  },
                                              })
                                    }),
                          ),
                        ],
                      )),
                  MySection(
                      title: "Комментарий",
                      subtitle: "Введите заметку к записи",
                      divider: true,
                      infoText: "Необязательное поле",
                      body: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: MyInput(
                              placeholder: "Заметка к записи долга",
                              maxLines: 4,
                              onTap: () => unfocus(action: false),
                              onChanged: this.commentCallback,
                            ),
                          )
                        ],
                      )),
                  MyButton(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: const Icon(Icons.add_circle, color: Colors.white, size: 20),
                        ),
                        const Text("Создать новый долг", style: const TextStyle(fontSize: 16))
                      ],
                    ),
                    onPressed: this.submitData,
                  )
                ],
              )),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.check,
              size: 30, color: Constans.PrimaryColor),
          onPressed: this.submitData
        ),
      ],
    ));
  }

  void unfocus({bool action=true}) {
    if(action == true) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
    amountUnfocus();
  }

  void amountUnfocus() {

    var value = _amountController.text;
    var filteredValue='0.0';

    var plusSlpitValue = value.split("+");

    if(plusSlpitValue.length > 1) {
      plusSlpitValue.forEach((valueItem) {
        if(valueItem.isNotEmpty) {
          double a = double.parse(amountUnfocusFilter(valueItem)); 
          double b = double.parse(filteredValue); 
          filteredValue = amountUnfocusFilter((a+b).toStringAsFixed(2).toString());
        }
      });
    }else {
      // amountListener(value);
      filteredValue = amountUnfocusFilter(value);
    }

    _amountController.value = TextEditingValue(
      text: filteredValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: filteredValue.length),
      ),
    );
  }

  amountUnfocusFilter(value) {
    var filteredValue = value;
    if(value.split(".").length > 1) {
      if(value.split(".")[1] == '00') {
        filteredValue = value.replaceAll('.00', '');
      }else if(value.split(".")[1] == '0') {
        filteredValue = value.replaceAll('.0', '');
      }else if(value.split("").last == '.') {
        filteredValue = value.replaceAll('.', '');
      }else if(value.split(".")[1].split("").last == '0') {
        filteredValue = value.substring(0, value.length-1);
      }
    }
    return filteredValue;
  }

  void amountListener(String v) {

    var value = v;
    if (value == ''){
      return;
    }
    var filteredValue = '';

    if(value[0] == '.' || value[0] == ',') {
      return;
    }

    filteredValue=_checkNumber(value);

    _amountController.value = TextEditingValue(
      text: filteredValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: filteredValue.length),
      ),
    );
  }

  _checkNumber(String v) {
    var value = v;
    print(value);
    String filteredValue='';
    bool dot = false;
     
     var qwe;

    var plusSlpitValue = value.split("+");
    if(plusSlpitValue.length > 1) {
      qwe = plusSlpitValue;
    }else {
      qwe = value.runes;
    }
  
    qwe.forEach((int rune) {
      var character = String.fromCharCode(rune);
      if(character == '.' || character == ',') {
        if(!dot) {
          dot=true;
          filteredValue += '.';
        }
      }else {
        if(dot) {
          int dotIndex = filteredValue.indexOf('.')+1;
          int length = filteredValue.length+1;
          if(length - dotIndex <= 2) {
            filteredValue += character;
          }
        }else {
          filteredValue += character;
        }
      }
    });
    setState(() {});
    return filteredValue;
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void submitData() {

    // if(_amount) {

    // }

    print("-----------------------------------");
    print("Amount: $_amount");
    print("Currency: $_selectedCurrency");
    print("Action: $_selectedAction");
    print("Contacts: $_contacts");
    print("Start date: $_startDate");
    print("End date: $_endDate");
    print("Comment: $_comment");
    print("-----------------------------------");
  }

  Future<void> _showContactRepeatDialog({context, type}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Этот контакт уже добавлен'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Добавленный вами контакт уже есть в списке.'),
                if(type == 2 || type == 3)
                Text('Хотите выбрать другой вариант добавления?'),
              ],
            ),
          ),
          actions: <Widget>[
            if(type == 2 || type == 3)
            FlatButton(
              child: Text('Отмена', style: TextStyle(color: Constans.Grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if(type == 1)
            FlatButton(
              child: Text('Понятно', style: TextStyle(color: Constans.PrimaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if(type == 2 || type == 3)
            FlatButton(
              child: Text('Выбрать другой вариант', style: TextStyle(color: Constans.PrimaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
                return ContactModal(
                    context: context,
                    callback: this.newContactCallback
                  );
              },
            )
          ],
        );
      },
    );
  }

}
