import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date{
  static String format(DateTime tm) {

    String day = DateFormat('dd').format(tm);
    String year = DateFormat('yyyy').format(tm);

    String month;

    String result;

    switch (tm.month) {
      case 1:
        month = "Янв";
        break;
      case 2:
        month = "Фев";
        break;
      case 3:
        month = "Март";
        break;
      case 4:
        month = "Апр";
        break;
      case 5:
        month = "Май";
        break;
      case 6:
        month = "Июн";
        break;
      case 7:
        month = "Июл";
        break;
      case 8:
        month = "Авг";
        break;
      case 9:
        month = "Сен";
        break;
      case 10:
        month = "Окт";
        break;
      case 11:
        month = "Ноя";
        break;
      case 12:
        month = "Дек";
        break;
    }

    if(DateFormat('dd-MM-yy').format(tm) == DateFormat('dd-MM-yy').format(DateTime.now())) {
      result = "Сегодня";
    }else {
      result = '$day $month, $year';
    }

    return result;
  }

  static void showPicker({context, int type=0, DateTime initialDate, DateTime firstDate, DateTime lastDate, Function callable}) {
    
    int infDays = 30 * 12 * 100;

    DateTime infinityBefore = DateTime.now().add(Duration(days: infDays * -1));
    DateTime infinityAfter = DateTime.now().add(Duration(days: infDays));

    DateTime now = DateTime.now();

    DateTime _initialDate;
    DateTime _firstDate;
    DateTime _lastDate;

    if(initialDate != null) {
      _initialDate = initialDate;
    }else {
      if(type == 1) {
        _initialDate = now;
      }else if(type == 2) {
        _initialDate = now;
      }
    }

    if(firstDate != null) {
      _firstDate = firstDate;
    }else {
      if(type == 1) {
        _firstDate = infinityBefore;
      }else if(type == 2) {
        _firstDate = now;
      }
    }

    if(lastDate != null) {
      _lastDate = lastDate;
    }else {
      if(type == 1) {
        _lastDate = now;
      }else if(type == 2) {
        _lastDate = infinityAfter;
      }
    }

    showDatePicker(
      context: context,
      cancelText: "Отмена",
      confirmText: "Добавить",
      helpText: "Укажите дату",
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: _initialDate,
      firstDate: _firstDate,
      lastDate:_lastDate
    ).then((pickedDate) => {
          callable(pickedDate)
      });
  }
}