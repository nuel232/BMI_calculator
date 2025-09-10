import 'package:bmi_calculator/database/db.dart';
import 'package:bmi_calculator/models/info.dart';
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
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 10, bottom: 5),
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          Info info = entry['info'] as Info;

                          return AlertDialog(
                            title: Text("Details"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Age: ${info.Age}"),
                                Text("Height: ${info.height} cm"),
                                Text("Weight: ${info.weight} kg"),
                                Text("Gender: ${info.selectGender ?? 'N/A'}"),
                              ],
                            ),
                          );
                        },
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(entry['bmi'].toStringAsFixed(1)),
                          subtitle: Text(entry['category']),
                          trailing: Text(
                            DateTime.parse(
                              entry['timestamp'],
                            ).toString().substring(0, 10), // Shows YYYY-MM-DD
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
