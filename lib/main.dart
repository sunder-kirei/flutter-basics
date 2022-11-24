import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<TransactionModel> tsx = [];

  Future<List<TransactionModel>> getSharedPrefs() async {
    final result = await SharedPreferences.getInstance();
    print("here 1");
    List<Map<String, dynamic>> tsx = result.containsKey("tsx")
        ? json.decode(result.getString("tsx") as String)
        : [];
    print("here 2");
    final List<TransactionModel> tsxList = tsx
        .map(
          (map) => TransactionModel(
            amount: double.parse(map["amount"]),
            title: map["title"],
            date: DateTime.parse(map["date"]),
          ),
        )
        .toList();

    print("here 3");

    return tsxList;
  }

  @override
  void initState() {
    getSharedPrefs().then((value) => tsx = value);
    // SharedPreferences.getInstance().then((value) => value.clear());
    super.initState();
  }

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
    final formatTitle = title.text[0].toUpperCase() + title.text.substring(1);

    setState(
      () {
        tsx.add(
          TransactionModel(
            amount: double.parse(amount.text),
            date: date,
            title: formatTitle,
          ),
        );
      },
    );
    Navigator.of(context).pop();

    SharedPreferences.getInstance()
        .then((prefs) => prefs.containsKey("tsx") ? prefs.getString("tsx") : "")
        .then(
      (prefs) {
        if (prefs == "") {
          SharedPreferences.getInstance().then(
            (value) => value.setString(
              "tsx",
              json.encode(
                {
                  "amount": "amount",
                  "date": date.toIso8601String(),
                  "title": formatTitle,
                },
              ),
            ),
          );
          return;
        }
        List<Map<String, dynamic>> oldTsx = json.decode(prefs as String);
        oldTsx.add({
          "amount": "amount",
          "date": date.toIso8601String(),
          "title": formatTitle,
        });
        SharedPreferences.getInstance().then(
          (value) => value.setString(
            "tsx",
            json.encode(oldTsx),
          ),
        );
      },
    );
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
