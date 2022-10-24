import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function onSubmit;

  const AddTransaction({super.key, required this.onSubmit});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController(text: '');
  final amountController = TextEditingController(text: '');
  DateTime date = DateTime.now();

  //you can get the parent widget's properties using the widget property😲😲😲🤯

  String currentDate = '';

  void editingCompleteCheck() {
    if (amountController.text != '' && titleController.text != '') {
      widget.onSubmit(
        titleController,
        amountController,
        date,
        context,
      );
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            margin: const EdgeInsets.only(
              bottom: 4,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Title',
                icon: Icon(
                  Icons.edit_note_rounded,
                  size: 30,
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
                decoration: TextDecoration.none,
              ),
              controller: titleController,
              onEditingComplete: editingCompleteCheck,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Amount',
                icon: Icon(
                  Icons.currency_rupee_rounded,
                  size: 30,
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
                decoration: TextDecoration.none,
              ),
              keyboardType: TextInputType.number,
              controller: amountController,
              onEditingComplete: editingCompleteCheck,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
            ),
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.parse("2022-01-01"),
                        lastDate: DateTime.now().add(
                          const Duration(
                            days: 7,
                          ),
                        ),
                      ).then((value) {
                        if (value == null) return;
                        date = value;
                        setState(() {
                          currentDate = DateFormat.yMMMd('en_US').format(value);
                        });
                      });
                    },
                    child: Text(
                      currentDate == '' ? "Add Date" : currentDate,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              right: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: editingCompleteCheck,
                  child: const Text('Add Transaction'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
