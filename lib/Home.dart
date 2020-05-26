import 'package:Loan/components/LoanItem.dart';
import 'package:flutter/material.dart';
import 'package:Loan/components/EmptyLoan.dart';

class Home extends StatelessWidget {
  final items = List<String>.generate(15, (i) => "Item $i");
  final bool isEmpty = false;
  final int page;

  // In the constructor, require a Todo.
  Home({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isEmpty == true
          ? const EmptyLoan()
          : Container(
            child: ListView.builder(
              itemCount: items.length,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 80),
              itemBuilder: (context, index) {
                return LoanItem();
              },
           ),
          )
    );
  }
}
