import 'package:bmi_calculator/database/db.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //reference the hive box
  final _myBMI = Hive.box('myBMI');

  BMIDatabase db = BMIDatabase();
  List history = [];

  @override
  void initState() {
    super.initState();
    history = db.getAllEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: db.getAllEntries().isEmpty
          ? Center(
              child: Text(
                'No previous Result yet...',
                style: TextStyle(color: Colors.grey.shade300),
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                int reverseIndex = history.length - 1 - index;
                var entry = history[reverseIndex];

                return Column(
                  children: [ListTile(title: Text(entry['Category']))],
                );
              },
            ),
    );
  }
}
