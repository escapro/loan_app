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

    if(DateFormat('dd').format(tm) == DateFormat('dd').format(DateTime.now())) {
      result = "Сегодня";
    }else {
      result = '$day $month, $year';
    }

    return result;
  }

  static void showPicker({context, DateTime initialDate, DateTime firstDate, DateTime lastDate, Function callable}) {
    
    Duration infinity = Duration(days: 30 * 12 * 100);

    showDatePicker(
      context: context,
      cancelText: "Отмена",
      confirmText: "Добавить",
      helpText: "Укажите дату",
      initialDate: initialDate == null ? DateTime.now() : initialDate,
      firstDate: firstDate == null ? DateTime.now() : firstDate,
      lastDate: lastDate == null ? DateTime.now().add(infinity) : lastDate,
    ).then((pickedDate) => {
          callable(pickedDate)
      });
  }
}