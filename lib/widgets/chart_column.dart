import 'package:flutter/material.dart';

class ChartColumn extends StatelessWidget {
  final double percentageTotal;
  final String day;
  final String amount;

  const ChartColumn(
      {super.key,
      required this.percentageTotal,
      required this.day,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
        ),
        child: Column(
          children: [
            Text(day),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: percentageTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.only(
                          top: 4,
                        ),
                        alignment: Alignment.topCenter,
                        child: Text(
                          amount,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
