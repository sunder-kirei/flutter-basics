import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

import '../widgets/chart_column.dart';

class ChartScreen extends StatelessWidget {
  List<TransactionModel> tsx;
  ChartScreen({super.key, required this.tsx});

  List<Map<String, String>> get groupedTsx {
    const List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return List.generate(7, (index) {
      double amount = 0;
      double totalAmount = 0;

      for (int i = 0; i < tsx.length; i++) {
        if (tsx[i].date.weekday == index + 1) {
          amount += tsx[i].amount;
        }
        totalAmount += tsx[i].amount;
      }
      double percentageTotal = 0;
      percentageTotal = (amount / totalAmount);

      return {
        "day": days[index],
        "percentageTotal": percentageTotal.toStringAsFixed(2),
        "amount": amount.toStringAsFixed(1),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 4,
        right: 4,
        bottom: 6,
      ),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 8,
          ),
          child: Row(
            children: groupedTsx
                .map(
                  (item) => ChartColumn(
                    day: item['day'] as String,
                    percentageTotal: double.parse(item['percentageTotal']!),
                    amount: item['amount'] as String,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
