import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../widgets/transaction.dart';

class TransactionScreen extends StatelessWidget {
  final List<TransactionModel> transactionList;
  final Function delTsx;

  const TransactionScreen(
      {super.key, required this.transactionList, required this.delTsx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Transaction(
            tsx: transactionList[index],
            delTsx: delTsx,
          );
        },
        itemCount: transactionList.length,
      ),
    );
  }
}
