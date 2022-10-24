import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';

class Transaction extends StatelessWidget {
  final TransactionModel tsx;
  final Function delTsx;
  const Transaction({required this.tsx, required this.delTsx, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: () {},
        leading: Icon(
          Icons.account_balance_wallet_rounded,
          size: 35,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          tsx.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        subtitle: Text(
          "${(tsx.amount).toStringAsFixed(2)}\t\t\t\t\t${DateFormat.yMMMd().format(tsx.date)}",
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          color: Theme.of(context).colorScheme.error,
          onPressed: () => delTsx(tsx),
        ),
      ),
    );
  }
}
