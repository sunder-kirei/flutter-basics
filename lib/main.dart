import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

import './models/transaction_model.dart';
import './screens/transaction_screen.dart';
import './widgets/add_transaction.dart';
import './screens/empty_transaction.dart';
import 'screens/chart_screen.dart';

void main() {
  runApp(const MyApp());
}

Color brandColor = const Color(0XFF171A9E);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<TransactionModel> tsx = [];

  List<TransactionModel> get recentTsx {
    return tsx
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void onSubmit(
    TextEditingController title,
    TextEditingController amount,
    DateTime date,
    BuildContext context,
  ) {
    setState(
      () {
        tsx.add(
          TransactionModel(
            amount: double.parse(amount.text),
            title: title.text[0].toUpperCase() + title.text.substring(1),
            date: date,
          ),
        );
      },
    );
    Navigator.of(context).pop();
  }

  void showAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return AddTransaction(
          onSubmit: onSubmit,
        );
      },
    );
  }

  void deleteTsx(TransactionModel delTsx) {
    setState(() {
      tsx.remove(delTsx);
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, dark) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && dark != null) {
          lightColorScheme = lightDynamic.harmonized()..copyWith();
          lightColorScheme = lightColorScheme.copyWith(secondary: brandColor);
          darkColorScheme = dark.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: brandColor);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: brandColor,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Personal Expences',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Personal Expences'),
              actions: [
                Builder(
                  builder: (context) => TextButton(
                    onPressed: () => showAddTransaction(context),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              width: double.infinity,
              child: tsx.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ChartScreen(
                          tsx: recentTsx,
                        ),
                        TransactionScreen(
                          transactionList: tsx,
                          delTsx: deleteTsx,
                        ),
                      ],
                    )
                  : const EmptyList(),
            ),
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () => showAddTransaction(context),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );
      },
    );
  }
}
