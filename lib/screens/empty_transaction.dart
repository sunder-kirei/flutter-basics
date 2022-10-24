import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.hourglass_empty_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 200,
        ),
        Container(
          height: 100,
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: const Text(
            'No transactions to display,\n try adding some!',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
