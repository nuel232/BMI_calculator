import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(),
    );
  }
}
