import 'package:flutter/material.dart';

class TransactionModel {
  final double amount;
  final String title;
  final DateTime date;

  TransactionModel({
    required this.amount,
    required this.title,
    required this.date,
  });
}
